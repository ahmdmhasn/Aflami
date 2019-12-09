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

protocol MovieAPIProtocol {
    func getNewMovies(page: Int, sortType: PopularMoviesSortType, completion: @escaping (MovieApiResponse?, Swift.Error?) -> ())
    func getTrailers(movieId: Int, completion: @escaping ([Trailer]?, Swift.Error?) -> ())
    func getCast(movieId: Int, completion: @escaping ([Cast]?, Swift.Error?) -> ())
    func getReviews(movieId: Int, completion: @escaping ([Review]?, Swift.Error?) -> ())
}

class NetworkManager {
    
    public static let shared = NetworkManager()
    
    private init() {}
    
    static let environment: NetworkEnvironment = .production
    static let myAPIKey = "e91d155831d8f6a5c7089243d189285b"
    let provider = MoyaProvider<MovieAPI>(plugins: [NetworkLoggerPlugin(verbose: false)])
}



extension NetworkManager: MovieAPIProtocol {
    
    func getNewMovies(page: Int, sortType: PopularMoviesSortType, completion: @escaping (MovieApiResponse?, Swift.Error?) -> ()) {
        provider.request(.popular(page: page, sortType: sortType)) { (result) in
            switch result {
            case let .success(response):
                do {
                    let apiResponse = try JSONDecoder().decode(MovieApiResponse.self, from: response.data)
                    completion(apiResponse, nil)
                } catch {
                    print("\(#function): \(error)")
                    completion(nil, error)
                }
            case let .failure(error):
                print("\(#function): \(error)")
                completion(nil, error)
            }
        }
    }
    
    func getTrailers(movieId: Int, completion: @escaping ([Trailer]?, Swift.Error?) -> ()) {
        provider.request(.trailers(id: movieId)) { (result) in
            switch result {
            case let .success(response):
                do {
                    let json = try JSON(data: response.data)
                    completion(TrailersApiResponse(from: json).trailers, nil)
                } catch {
                    print("\(#function): \(error)")
                    completion(nil, error)
                }
            case let .failure(error):
                print("\(#function): \(error)")
                completion(nil, error)
            }
        }
    }
    
    func getCast(movieId: Int, completion: @escaping ([Cast]?, Swift.Error?) -> ()) {
        provider.request(.cast(id: movieId)) { (result) in
            switch result {
            case let .success(response):
                do {
                    let json = try JSON(data: response.data)
                    completion(CastApiResponse(from: json).cast, nil)
                } catch {
                    print("\(#function): \(error)")
                    completion(nil, error)
                }
            case let .failure(error):
                print("\(#function): \(error)")
                completion(nil, error)
            }
        }
    }
    
    func getReviews(movieId: Int, completion: @escaping ([Review]?, Swift.Error?) -> ()) {
        provider.request(.reviews(id: movieId)) { (result) in
            switch result {
            case let .success(response):
                do {
                    let json = try JSON(data: response.data)
                    completion(ReviewsApiResponse(from: json).reviews, nil)
                } catch {
                    print("\(#function): \(error)")
                    completion(nil, error)
                }
            case let .failure(error):
                print("\(#function): \(error)")
                completion(nil, error)
            }
        }
    }
    
}






