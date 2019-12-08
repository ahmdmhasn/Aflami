//
//  MovieModel.swift
//  Network Layer
//
//  Created by Ahmed M. Hassan on 7/31/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

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

// MARK: - Data persistance
extension Movie: Persistable {
    
    init(managedObject: MovieObject) {
        id = managedObject.id
        posterPath = managedObject.posterPath
        backdrop = managedObject.backdrop
        title = managedObject.title
        releaseDate = managedObject.releaseDate
        rating = managedObject.rating
        overview = managedObject.overview
    }
    
    func managedObject() -> MovieObject {
        let movie = MovieObject()
        movie.id = id
        movie.posterPath = posterPath
        movie.backdrop = backdrop
        movie.title = title
        movie.releaseDate = releaseDate
        movie.rating = rating
        movie.overview = overview
        
        return movie
    }
    
}

final class MovieObject: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var posterPath: String = ""
    @objc dynamic var backdrop: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var rating: Double = 0.0
    @objc dynamic var overview: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
