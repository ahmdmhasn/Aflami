//
//  NetworkManager.swift
//  Network Layer
//
//  Created by Ahmed M. Hassan on 7/31/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import Foundation

import Moya

protocol Networkable {
    var provider: MoyaProvider<MovieAPI> { get }
    func getNewMovies(page: Int, completion: @escaping ([Movie]?)->())
}

struct NetworkManager {    
    static let environment: NetworkEnvironment = .production
    static let myAPIKey = "e91d155831d8f6a5c7089243d189285b"
//    fileprivate let router = Router<MyAPI>()
    let provider = MoyaProvider<MovieAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
}



extension NetworkManager: Networkable{
    
    func getNewMovies(page: Int, completion: @escaping ([Movie]?) -> ()) {
        provider.request(.popular(page: page)) { (result) in
            switch result {
            case let .success(response):
//                let json = JSON(data: response.data)
//                completion(MovieApiResponse(from: json).movies)
                break
            case let .failure(error):
                print(error)
                completion(nil)
            }
        }
    }
    
}






