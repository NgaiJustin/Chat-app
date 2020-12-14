from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class User(db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(128), unique=True)
    password = db.Column(db.String(128))
    first_name = db.Column(db.String(256))
    last_name = db.Column(db.String(256))

    def __init__(self, **kwargs):
        self.username = kwargs.get("username")
        self.password = kwargs.get("password")
        self.first_name = kwargs.get("first_name")
        self.last_name = kwargs.get("last_name")

    def serialize(self):
        return {
            "user_id": self.id,
            "username": self.username,
            "first_name": self.first_name,
            "last_name": self.last_name 
        }

class Channel(db.Model):
    __tablename__ = 'channels'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(256))
    fr = db.Column(db.Integer, db.ForeignKey('users.id'))
    to = db.Column(db.Integer, db.ForeignKey('users.id'))

    def __init__(self, **kwargs):
        self.name = kwargs.get("name")
        self.fr = kwargs.get("fr")
        self.to = kwargs.get("to")
        
    def serialize(self):
        return {
            "channel_id": self.id,
            "channel_name": self.name,
            "from": self.fr,
            "to": self.to
        }

class Message(db.Model):
    __tablename__ = 'messages'
    id = db.Column(db.Integer, primary_key=True)
    message = db.Column(db.Text)
    fr = db.Column(db.Integer, db.ForeignKey('users.id'))
    to = db.Column(db.Integer, db.ForeignKey('users.id'))
    channel_name = db.Column(db.Integer, db.ForeignKey('channels.name'))

    def __init__(self, **kwargs):
        self.message = kwargs.get("message")
        self.channel_name = kwargs.get("channel_name")
        self.fr = kwargs.get("fr")
        self.to = kwargs.get("to")
        
    def serialize(self):
        return {
            "message_id": self.id,
            "message": self.contents,
            "from": self.fr,
            "to": self.to,
            "channel_name": self.channel_id 
        }