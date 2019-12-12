//
//  MovieDetailsRouter.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 12/10/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import UIKit.UIStoryboard

class MovieDetailsRouter {
    
    public class func createView(movie: Movie) -> MovieDetailsVC {
        
        let movieDetailsVC = MovieDetailsVC(nibName: "\(MovieDetailsVC.self)", bundle: nil)
        
        movieDetailsVC.viewModel = MovieDetailsViewModel(movie: movie)
        
        return movieDetailsVC
    }
            
}
