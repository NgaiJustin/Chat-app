from db import db
from flask import Flask
import json
import os
from db import Course, Assignment, User
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
    
    #TODO

@app.route("/api/newChat/", methods=["POST"])
def newChat():
    body = json.loads(request.data)

    # We check if a channel exists between the from and to users, if not we create one; if it already exists we use that channel.
    # will use some stuff from pusher here

@app.route("/api/pusher/authentication", methods=["POST"])
def pusher_authentication():
    # This will be used to authorize channels. pusher requires this, nth to do with the app itself. will help handle sockets and realtime stuff

@app.route("/api/sendMsg", methdos=["POST"])
def sendMsg():
    pass

@app.route("/api/getMsg/<int:channel_id>/", methods=["GET"])
def getMsg(channel_id):
    pass

@app.route("/api/getAllUsers/", methods=["GET"])
def getAllUsers():
    pass
