//
//  User.swift
//  CornellChat
//
//  Created by Abby Levin on 12/6/20.
//

import Foundation

struct UserDataResponse: Codable {
    let users: [User]
}

struct Recipient {
    var imageName : String
    var id : String // user id - not sure if this is a string
    var username : String
}

enum Direction {
    case incoming
    case outgoing
}

struct Message: Codable {
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

struct UserResponse: Codable {
    var success : Bool
    var data : User
}

struct User: Codable {
    static var current : User?
    var userId : Int? // user id - not sure if this is a string
    var username : String // not sure if this is a string
    var firstName : String?
    var lastName : String?
    var token : String?
}

struct Chat: Codable {
    var from : Int
    var to : Int
    var fromChannel : String
    var toChannel : String
    var channelName : String
}

struct MessageBackend: Codable { // should this be the response from getMsg or send Msg?
    var messageId : Int // message id - not sure if it is a string
    var messageContents : String
    var from : User
    var to : User
    var channel : String
}




