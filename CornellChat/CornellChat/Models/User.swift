//
//  User.swift
//  CornellChat
//
//  Created by Abby Levin on 12/6/20.
//

import Foundation

struct Recipient {
    var imageName : String
    var id : String // user id - not sure if this is a string
    var username : String
}

enum Direction {
    case incoming
    case outgoing
}

struct Message {
    var id : String? // message id - not sure if it is a string
    var contents : String
    var to : User
    var from : User
    var time : String
}

struct Conversation {
    var id : String  //channel id - not sure if it is a string
    var name : String // channel name - not sure if it is a string (could also just use recipient.username)
    var messages : [Message]
    var recipient : Recipient
}

struct User {
    static var current : User?
    var id : String // user id - not sure if this is a string
    var username : String // not sure if this is a string
    var password : String
    var imageName : String
    var conversations : [Conversation]
}

