//
//  Trailer.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/7/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ApiResponse {
    let page: Int
    let trailers: [Trailer]
}

extension ApiResponse {
    private enum ResponseCodingKeys: String {
        case page
        case trailers = "results"
    }
    
    init(from json: JSON) {
        page = json[ResponseCodingKeys.page.rawValue].intValue
        trailers = json[ResponseCodingKeys.trailers.rawValue].arrayValue.map{Trailer(from: $0)}
    }
}

struct Trailer {
    
    let key: String
    let name: String
    let site: String
    let size: Int
    let type: String
    
}

extension Trailer {
    
    enum TrailerCodingKeys: String {
        case key
        case name
        case site
        case size
        case type
    }
    
    
    init(from json: JSON) {
        key = json[TrailerCodingKeys.key.rawValue].stringValue
        name = json[TrailerCodingKeys.name.rawValue].stringValue
        site = json[TrailerCodingKeys.site.rawValue].stringValue
        size = json[TrailerCodingKeys.size.rawValue].intValue
        type = json[TrailerCodingKeys.type.rawValue].stringValue
    }
}
