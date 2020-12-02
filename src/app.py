from db import db
from flask import Flask
import json
import os
from db import User, Channel, Message
from flask import request
app = Flask(__name__)
db_filename = "chat.db"

# Pusher part. no clue what this does rn, copied straight from their website
pusher = pusher.Pusher(
    app_id=os.getenv('PUSHER_APP_ID'),
    key=os.getenv('PUSHER_KEY'),
    secret=os.getenv('PUSHER_SECRET'),
    cluster=os.getenv('PUSHER_CLUSTER'),
    ssl=True)

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

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
    # apparently generating pwd hash is a library method in werkzeug, no need to implement it
    newUser = User(username = username, password = password)
    db.session.add(newUser)
    db.session.commit()
    return success_response(newUser.serialize())

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
    return success_response(json.dumps({
            "id": user.id,
            "token": access_token,
            "username": user.username
        }))

@app.route("/api/newChat/", methods=["POST"])
def newChat():
    pass


@app.route("/api/pusher/authentication", methods=["POST"])
def pusher_authentication():
    # This will be used to authorize channels. pusher requires this, nth to do with the app itself. will help handle sockets and realtime stuff
    body = json.loads(request.data)
    channel_name = body.get('channel_name')
    socket_id = body.get('socket_id')
    response = pusher.authenticate(
        channel=channel_name,
        socket_id=socket_id
    )
    return success_response(json.dumps(response))

@app.route("/api/sendMsg", methdos=["POST"])
def sendMsg():
    body = json.loads(request.data)
    fr = body.get("from_user")
    to = body.get("to_user")
    message = body.get("message")
    channel_id = body.get("channel_id")

    new_message = Message(message=message, channel_id=channel_id)
    new_message.fr = fr
    new_message.to = to
    db.session.add(new_message)
    db.session.commit()

    message = new_message.serialize()

    pusher.trigger(channel_id, 'new_message', message)
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
