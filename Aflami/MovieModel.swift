//
//  MovieModel.swift
//  Network Layer
//
//  Created by Ahmed M. Hassan on 7/31/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MovieApiResponse {
    let page: Int
    let numberOfResults: Int
    let numberOfPages: Int
    let movies: [Movie]
}

extension MovieApiResponse {
    private enum ResponseCodingKeys: String {
        case page
        case numberOfResults = "total_results"
        case numberOfPages = "total_pages"
        case movies = "results"
    }
    
    init(from json: JSON) {
        page = json[ResponseCodingKeys.page.rawValue].intValue
        numberOfResults = json[ResponseCodingKeys.numberOfResults.rawValue].intValue
        numberOfPages = json[ResponseCodingKeys.numberOfPages.rawValue].intValue
        movies = json[ResponseCodingKeys.movies.rawValue].arrayValue.map{Movie(from: $0)}
    }
}



struct Movie {
    let id: Int
    let posterPath: String
    let backdrop: String
    let title: String
    let releaseDate: String
    let rating: Double
    let overview: String
}

extension Movie {
    
    enum MovieCodingKeys: String {
        case id
        case posterPath = "poster_path"
        case backdrop = "backdrop_path"
        case title
        case releaseDate = "release_date"
        case rating = "vote_average"
        case overview
    }
    
    
    init(from json: JSON) {
        id = json[MovieCodingKeys.id.rawValue].intValue
        posterPath = json[MovieCodingKeys.posterPath.rawValue].stringValue
        backdrop = json[MovieCodingKeys.backdrop.rawValue].stringValue
        title = json[MovieCodingKeys.title.rawValue].stringValue
        releaseDate = json[MovieCodingKeys.releaseDate.rawValue].stringValue
        rating = json[MovieCodingKeys.rating.rawValue].doubleValue
        overview = json[MovieCodingKeys.overview.rawValue].stringValue
    }
    
}

