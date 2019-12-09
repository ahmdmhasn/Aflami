//
//  FavouriteMoviesVCRouter.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/9/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import UIKit

class FavouriteMoviesVCRouter {
    
    func navigateToMovieDetails(from view: FavouriteMoviesVCDelegate, movie: Movie, movieInteractor: MovieInteractor) {
        let userDetailsView = MovieDetailsVCRouter.creatMovieDetailsVC(movie: movie, movieInteractor: movieInteractor)
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(userDetailsView, animated: true)
        }
    }
    
}
