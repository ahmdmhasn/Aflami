//
//  Cast.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/7/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CastApiResponse {
    let page: Int
    let cast: [Cast]
}

extension CastApiResponse {
    private enum ResponseCodingKeys: String {
        case page
        case results = "cast"
    }
    
    init(from json: JSON) {
        page = json[ResponseCodingKeys.page.rawValue].intValue
        cast = json[ResponseCodingKeys.results.rawValue].arrayValue.map{Cast(from: $0)}
    }
}

struct Cast {
    
    let id : String
    let character : String
    let name : String
    let profilePath : String
    
}

extension Cast {
    
    enum CodingKeys: String {
        case id = "id"
        case character
        case name
        case profilePath = "profile_path"
    }
    
    
    init(from json: JSON) {
        id = json[CodingKeys.id.rawValue].stringValue
        character = json[CodingKeys.character.rawValue].stringValue
        name = json[CodingKeys.name.rawValue].stringValue
        profilePath = json[CodingKeys.profilePath.rawValue].stringValue
    }
}
