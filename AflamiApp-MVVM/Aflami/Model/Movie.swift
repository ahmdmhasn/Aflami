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

// MARK: - Movie
struct Movie: Codable {
    let posterPath: String?
    let id: Int
    let backdropPath: String?
    let title: String?
    let overview, releaseDate: String?
    let voteAverage: Double?

    let popularity: Double? = nil
    let voteCount: Int? = nil
    let video: Bool? = nil
    let adult: Bool? = nil
    let originalLanguage: OriginalLanguage? = nil
    let originalTitle: String? = nil
    let genreIDS: [Int]? = nil

    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case id, adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
}

enum OriginalLanguage: String, Codable {
    case cn = "cn"
    case en = "en"
}

// MARK: - Data persistance
extension Movie: Persistable {
    
    init(managedObject: MovieObject) {
        id = managedObject.id
        posterPath = managedObject.posterPath
        backdropPath = managedObject.backdrop
        title = managedObject.title
        releaseDate = managedObject.releaseDate
        voteAverage = managedObject.rating
        overview = managedObject.overview
    }
    
    func managedObject() -> MovieObject {
        let movie = MovieObject()
        movie.id = id
        movie.posterPath = posterPath ?? ""
        movie.backdrop = backdropPath ?? ""
        movie.title = title ?? ""
        movie.releaseDate = releaseDate ?? ""
        movie.rating = voteAverage ?? Double.zero
        movie.overview = overview ?? ""
        
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
