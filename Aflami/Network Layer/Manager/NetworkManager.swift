//
//  NetworkManager.swift
//  Network Layer
//
//  Created by Ahmed M. Hassan on 7/31/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import Foundation
import SwiftyJSON
import Moya

protocol Networkable {
    
    var provider: MoyaProvider<MovieAPI> { get }
    
    //func getNewMovies(page: Int, completion: @escaping ([Movie]?)->())
}

class NetworkManager {
    
    public static let shared = NetworkManager()
    
    private init() {}
    
    static let environment: NetworkEnvironment = .production
    static let myAPIKey = "e91d155831d8f6a5c7089243d189285b"
    let provider = MoyaProvider<MovieAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
}



extension NetworkManager: Networkable{
    
    func getNewMovies(page: Int, completion: @escaping ([Movie]?, Swift.Error?) -> ()) {
        provider.request(.popular(page: page)) { (result) in
            switch result {
            case let .success(response):
                let json = JSON(data: response.data)
                completion(MovieApiResponse(from: json).movies, nil)
            case let .failure(error):
                print(error)
                completion(nil, error)
            }
        }
    }
    
    func getTrailers(movieId: Int, completion: @escaping ([Trailer]?, Swift.Error?) -> ()) {
        provider.request(.trailers(id: movieId)) { (result) in
            switch result {
            case let .success(response):
                let json = JSON(data: response.data)
                completion(TrailersApiResponse(from: json).trailers, nil)
            case let .failure(error):
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
    
    func getCast(movieId: Int, completion: @escaping ([Cast]?, Swift.Error?) -> ()) {
        provider.request(.cast(id: movieId)) { (result) in
            switch result {
            case let .success(response):
                let json = JSON(data: response.data)
                completion(CastApiResponse(from: json).cast, nil)
            case let .failure(error):
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
    
    func getReviews(movieId: Int, completion: @escaping ([Review]?, Swift.Error?) -> ()) {
        provider.request(.reviews(id: movieId)) { (result) in
            switch result {
            case let .success(response):
                let json = JSON(data: response.data)
                completion(ReviewsApiResponse(from: json).reviews, nil)
            case let .failure(error):
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
    
}






