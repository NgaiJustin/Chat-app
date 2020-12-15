//
//  NetworkManager.swift
//  CornellChat
//
//  Created by Justin Ngai on 6/12/2020.
//

import Foundation
import Alamofire

enum ExampleDataResponse<T: Any> {
    case success(data: T)
    case failure(error: Error)
}

// How do we make network calls?

class NetworkManager {

    static let endpoint = "https://cornell-chat-app.herokuapp.com/"
    
    static func signin(username: String,
                       pw: String,
                       first: String,
                       last: String,
                       completion: @escaping (User) -> Void) {
        let parameters: [String: Any] = [
            "username": username,
            "password": pw,
            "first_name": first,
            "last_name": last
        ]
        let signinEndpoint = "\(endpoint)api/signin/"
        AF.request(signinEndpoint, method: .post, parameters: parameters,
                   encoding: JSONEncoding.default).validate().responseData { response in
                switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let userData = try? jsonDecoder.decode(UserResponse.self, from: data){
                    print("IT WORKED")
                    print(userData)
                    completion(userData.data)
                }
            case .failure(let error):
                print("HELLO")
                print(response)
                print(error) // for debugging again
            }
        }
    }
    
    static func login(username: String, password: String, completion: @escaping (User) -> Void)
    {
        let parameters: [String: Any] = [
            "username": username,
            "password": password,
        ]
        let loginEndpoint = "\(endpoint)api/login/"
        AF.request(loginEndpoint, method: .post, parameters: parameters,
                   encoding: JSONEncoding.default).validate().responseData { response in
                switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let userLogin = try? jsonDecoder.decode(UserResponse.self, from: data){
                    completion(userLogin.data)
                }
            case .failure(let error):
                print(error) // for debugging again
            }
        }
        
        func newChat(from: Int, to: Int, completion: @escaping (Chat) -> Void) //how do you add the header???
        {
            let parameters: [String: Any] = [
                "from": from,
                "to": to,
            ]
            let header: HTTPHeaders = [
                "Authorization": "Bearer \(User.current?.token)"
            ]
            let newChatEndpoint = "\(endpoint)api/newChat/"
            AF.request(newChatEndpoint, method: .post, parameters: parameters,
                       encoding: JSONEncoding.default, headers: header).validate().responseData { response in
                    switch response.result {
                case .success(let data):
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    if let chat = try? jsonDecoder.decode(Chat.self, from: data){
                        completion(chat)
                    }
                case .failure(let error):
                    print(error) // for debugging again
                }
            }
        }
            
        func sendMsg(from: Int, to: Int, message: String, channelName: String, completion: @escaping (MessageBackend) -> Void) //how do you add the header???
            {
                let parameters: [String: Any] = [
                    "from": from,
                    "to": to,
                    "message": message,
                    "channel_name": channelName,
                ]
            let header: HTTPHeaders = [
                "Authorization": "Bearer \(User.current?.token)"
            ]
                AF.request(endpoint, method: .post, parameters: parameters,
                           encoding: JSONEncoding.default, headers: header).validate().responseData { response in
                        switch response.result {
                    case .success(let data):
                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                        if let message = try? jsonDecoder.decode(MessageBackend.self, from: data){
                            completion(message)
                        }
                    case .failure(let error):
                        print(error) // for debugging again
                    }
                }
            }

        func getMsg(messageId: Int, messageContents: String, from: Int, to: Int, channelName: String, completion: @escaping (MessageBackend) -> Void) //how do you add the header???
            {
                let parameters: [String: Any] = [
                    "message_id" : messageId,
                    "message_contents": messageContents,
                    "from": from,
                    "to": to,
                    "channel_name": channelName,
                ]
            let header: HTTPHeaders = [
                "Authorization": "Bearer \(User.current?.token)"
            ]
                AF.request(endpoint, method: .post, parameters: parameters,
                           encoding: JSONEncoding.default, headers: header).validate().responseData { response in
                        switch response.result {
                    case .success(let data):
                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                        if let message = try? jsonDecoder.decode(MessageBackend.self, from: data){
                            completion(message)
                        }
                    case .failure(let error):
                        print(error) // for debugging again
                    }
                }
            }

        func getAllUsers(completion: @escaping (UserDataResponse) -> Void) //how do you add the header???
            {
            let header: HTTPHeaders = [
                "Authorization": "Bearer \(User.current?.token)"
            ]
                AF.request(endpoint, method: .post, parameters: parameters,
                           encoding: JSONEncoding.default, headers: header).validate().responseData { response in
                        switch response.result {
                    case .success(let data):
                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                        if let users = try? jsonDecoder.decode(UserDataResponse.self, from: data){
                            completion(users)
                        }
                    case .failure(let error):
                        print(error) // for debugging again
                    }
                }
            }
}
    
    
    
}
