//
//  MovieCellViewModel.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 12/9/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import Foundation

struct MovieCellViewModel {
    
    var title: String
    var url: URL
    
    init(withMovie movie: Movie) {
        title = movie.title ?? ""
        url = URL.getTMDBImage(type: .poster(path: movie.posterPath ?? "", size: .w342))
    }
}
