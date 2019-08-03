//
//  MyAPI.swift
//  Network Layer
//
//  Created by Ahmed M. Hassan on 7/31/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import Foundation
import Moya
import Alamofire

enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum MovieAPI {
    case recommended(id: Int)
    case popular(page: Int)
    case newMovies(page: Int)
    case video(id: Int)
    case login(userName: String, password: String)
    case register(userName: String, email: String, hashedPassword: String)
}

extension MovieAPI: TargetType {
    
    private var environmentBaseURL: String {
        switch NetworkManager.environment {
        case .production: return "https://api.themoviedb.org/3"
        case .qa: return "https://api.themoviedb.org/3"
        case .staging: return "https://api.themoviedb.org/3"
        }
    }
    
    /// The target's base `URL`.
    public var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else {
            fatalError("BaseURL could not be configured")
        }
        return url
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        switch self {
        case .recommended(let id):
            return "\(id)/recommendations"
        case .popular:
            return "/discover/movie"
        case .newMovies:
            return "now_playing"
        case .video(let id):
            return "\(id)/videos"
        case .login(let userName, let password):
            return userName + password // Edit this
        case .register(let userName, let email, let hashedPassword):
            return userName + email + hashedPassword
        }
    }
    
    /// The HTTP method used in the request.
    public var method: Moya.Method {
        switch self {
        case .login, .register:
            return .post
        default:
            return .get
        }
    }
    
    /// The parameters to be encoded in the request.
    public var parameters: [String: Any]? {
        switch self {
        case .popular(let page):
            return ["page": page, "api_key": NetworkManager.myAPIKey]
        default:
            return [:]
        }
    }
    
    /// The method used for parameter encoding.
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    /// Provides stub data for use in testing.
    // var sampleData: Data { get }
    
    /// The type of HTTP task to be performed.
    public var task: Task {
        switch self {
        default:
            return .request
        }
    }
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    public var validate: Bool {
        return false
    }
    
    public var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

