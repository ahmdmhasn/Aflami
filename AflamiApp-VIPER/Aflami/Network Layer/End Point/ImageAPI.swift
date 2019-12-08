//
//  ImageAPI.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/6/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import Foundation

enum LogoSize: String {
    case w45
    case w92
    case w154
    case w185
    case w300
    case w500
    case original
}

enum PosterSize: String {
    case w92
    case w154
    case w185
    case w342
    case w500
    case w780
    case original
}

enum ProfileSize: String {
    case w45
    case w185
    case h632
    case original
}

enum ImageAPI {
    case logo(path: String, size: LogoSize)
    case poster(path: String, size: PosterSize)
    case profile(path: String, size: ProfileSize)
}

extension URL {
    
    static func getTMDBImage(type: ImageAPI) -> URL {
        
        let baseURL: String = "https://image.tmdb.org/t/p/"
        
        var url: String!
        
        switch type {
        case .logo(let path, let size):
            url = baseURL + size.rawValue + path
        case .poster(let path, let size):
            url = baseURL + size.rawValue + path
        case .profile(let path, let size):
            url = baseURL + size.rawValue + path
        }
        
        guard let finalURL = URL(string: url) else {
            fatalError("Unable to create image url")
        }
        
        return finalURL
    }
    
}



