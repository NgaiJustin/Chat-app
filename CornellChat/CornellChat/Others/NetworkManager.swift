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

    static let endpoint = "addThisLater"

//    static func getMsg(completion: @escaping (Message) -> Void) {
//        AF.request(endpoint, method: HTTPMethod.get).validate().responseJSON { response in
//            switch response.result {
//            case .success(let data):
//                let jsonDecoder = JSONDecoder()
//                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
//                if let message = try?
//                    jsonDecoder(Message.self, from: data){
//                    completion(message)
//                    
//                }
//            case .failure(let error):
//                print(error) // for debugging again
//            }
//        }
//    }

}
