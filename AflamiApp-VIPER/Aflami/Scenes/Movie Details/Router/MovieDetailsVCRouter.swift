//
//  MovieDetailsVCRouter.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/8/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import UIKit

class MovieDetailsVCRouter {
    
    class func creatMovieDetailsVC(movie: Movie, movieInteractor: MovieInteractor) -> UIViewController {
        
        let movieDetails = mainStoryboard.instantiateViewController(withIdentifier: "MovieDetailsVC")
        
        if let movieDetails = movieDetails as? MovieDetailsDelegate {
            
            let router = MovieDetailsVCRouter()
            
            let presenter = MovieDetailsPresenter(movie: movie, view: movieDetails, interactor: movieInteractor, router: router)
            
            movieDetails.presenter = presenter
        }
        return movieDetails
    }
    
    class var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
}
