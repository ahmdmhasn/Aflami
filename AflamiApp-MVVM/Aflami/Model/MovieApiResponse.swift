//
//  MovieApiResponse.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/6/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import Foundation
import SwiftyJSON

// MARK: - MovieApiResponse
struct MovieApiResponse: Codable {
    let page, totalResults, totalPages: Int
    let movies: [Movie]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movies = "results"
    }
}
