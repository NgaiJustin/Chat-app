from db import db
from flask import Flask
import json
import os
from db import User, Channel, Message
from flask import request
from flask_jwt_extended import create_access_token, JWTManager, get_jwt_identity, jwt_required
from werkzeug.security import generate_password_hash, check_password_hash
import pusher
app = Flask(__name__)
db_filename = "chat.db"

# Pusher part. no clue what this does rn, copied straight from their website
pusher = pusher.Pusher(
  app_id='1120057',
  key='f39add8f660b0ebd7235',
  secret='924b478a579bc52d26c5',
  cluster='ap2',
  ssl=True
)

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True
app.config["JWT_SECRET_KEY"] = '4463894327891'
jwt = JWTManager(app)

db.init_app(app)
with app.app_context():
    db.create_all()

def success_response(data, code=200):
    return json.dumps({"success": True, "data": data}), code

def failure_response(message, code=404):
    return json.dumps({"success": False, "error": message}), code


@app.route("/api/signin/", methods=["POST"])
def signIn():
    body = json.loads(request.data)
    username = body.get("username")
    password = generate_password_hash(body.get("password"))
    first_name = body.get("first_name")
    last_name = body.get("last_name")

    user = User.query.filter_by(username=username).first()
    if not user:
        newUser = User(username = username, password = password, first_name = first_name, last_name = last_name)
        db.session.add(newUser)
        db.session.commit()
        return success_response(newUser.serialize())
    else:
        return failure_response("Account already exists, try loggin in instead.")
    


@app.route("/api/login/", methods=["POST"])
def logIn():
    body = json.loads(request.data)
    username = body.get("username")
    password = body.get("password")

    #first get the user associated with this username, then we will check if the hashes of the passwords match
    user = User.query.filter_by(username=username).first()
    if not user:
        return failure_response("User data not present in database")
    
    #check_password_hash is another library method
    if not check_password_hash(user.password, password):
        return failure_response("Incorrect password")
    
    access_token = create_access_token(identity=username)
    return success_response({ "user_id": user.id, "username": user.username, "token": access_token})

@app.route("/api/newChat/", methods=["POST"])
@jwt_required
def newChat():
    body = json.loads(request.data)
    fr = body.get("from")
    to = body.get("to")
    # according to pusher docs, the name for the channels have to be of the following format, starting with private-
    fr_channel = "private-chat_{}".format(fr)
    to_channel = "private-chat_{}".format(to)

    # check if there is a channel that already exists. this looks rather ugly but no idea how to do it otherwise. 
    # we first check if either of fr or to exists in the fr field of the channel table, then check the same for the to field. 
    # since there cannot be a msg from a user to themselves, this works

    channel = Channel.query.filter(Channel.fr.in_([fr, to])).filter(Channel.to.in_([fr, to])).first()
    if not channel:
        chat_channel = "private-chat_{}_{}".format(fr, to)
        new_channel = Channel(name=chat_channel, fr=fr, to=to)
        db.session.add(new_channel)
        db.session.commit()
    else:
        chat_channel = channel.name

    data = { "from": fr, "to": to, "from_channel": fr_channel, "to_channel": to_channel, "channel_name": chat_channel }

    pusher.trigger(to_channel, 'new_chat', data)
    return success_response(data)

@app.route("/api/pusher/authentication/", methods=["POST"])
@jwt_required
def pusherAuthentication():
    # This will be used to authorize channels. pusher requires this, nth to do with the app itself. will help handle sockets and realtime stuff
    body = json.loads(request.data)
    channel_name = body.get('channel_name')
    socket_id = body.get('socket_id')
    response = pusher.authenticate(channel=channel_name, socket_id=socket_id)
    return success_response(response)

@app.route("/api/sendMsg/", methods=["POST"])
@jwt_required
def sendMsg():
    body = json.loads(request.data)
    fr = body.get("from")
    to = body.get("to")
    message = body.get("message")
    channel_name = body.get("channel_name")

    new_message = Message(message=message, channel_id=channel_name, fr=fr, to=to)
    db.session.add(new_message)
    db.session.commit()

    message = new_message.serialize()

    pusher.trigger(channel_name, 'new_message', message)
    return success_response(message)

@app.route("/api/getMsg/<int:channel_id>/", methods=["GET"])
def getMsg(channel_id):
    all_messages = Message.query.filter(Message.channel_id == channel_id).all()
    messages = [m.serialize() for m in all_messages]
    return success_response(messages)

@app.route("/api/getAllUsers/", methods=["GET"])
def getAllUsers():
    users = [u.serialize() for u in User.query.all()]
    return success_response(users)

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port, debug=True)
