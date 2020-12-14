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

//    static func getMsg(completion: @escaping (Message) -> Void) {
//        AF.request(endpoint, method: HTTPMethod.get).validate().responseJSON { response in
//            switch response.result {
//            case .success(let data):
//                let jsonDecoder = JSONDecoder()
//                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
//                if let message = try?
//                    jsonDecoder(Message.self, from: data){
//                    completion(message)
//                }
//            case .failure(let error):
//                print(error) // for debugging again
//            }
//        }
//    }
    
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
        AF.request(endpoint, method: .post, parameters: parameters,
                   encoding: URLEncoding.queryString).validate().responseData { response in
                switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let user = try? jsonDecoder.decode(User.self, from: data){
                    print("IT WORKED")
                    print(user)
                    completion(user)
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
        AF.request(endpoint, method: .post, parameters: parameters,
                   encoding: URLEncoding.queryString).validate().responseData { response in
                switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let user = try? jsonDecoder.decode(User.self, from: data){
                    completion(user)
                }
            case .failure(let error):
                print(error) // for debugging again
            }
        }
        
    }

}
