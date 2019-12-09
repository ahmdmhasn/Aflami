//
//  Review.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/7/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ReviewsApiResponse {
    let page: Int
    let numberOfResults: Int
    let numberOfPages: Int
    let reviews: [Review]
}

extension ReviewsApiResponse {
    private enum ReviewsCodingKeys: String {
        case page
        case numberOfResults = "total_results"
        case numberOfPages = "total_pages"
        case results = "results"
    }
    
    init(from json: JSON) {
        page = json[ReviewsCodingKeys.page.rawValue].intValue
        numberOfResults = json[ReviewsCodingKeys.numberOfResults.rawValue].intValue
        numberOfPages = json[ReviewsCodingKeys.numberOfPages.rawValue].intValue
        reviews = json[ReviewsCodingKeys.results.rawValue].arrayValue.map{Review(from: $0)}
    }
}

struct Review {
    
    let id : String
    let author : String
    let content : String
    
}

extension Review {
    
    enum CodingKeys: String {
        case id
        case author
        case content
    }
    
    init(from json: JSON) {
        id = json[CodingKeys.id.rawValue].stringValue
        author = json[CodingKeys.author.rawValue].stringValue
        content = json[CodingKeys.content.rawValue].stringValue
    }
}
