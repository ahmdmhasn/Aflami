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
        
        let movieDetailsVC = storyboard.instantiateViewController(withIdentifier: "\(MovieDetailsVC.self)") as! MovieDetailsVC
        
        movieDetailsVC.viewModel = MovieDetailsViewModel(movie: movie)
        
        return movieDetailsVC
    }
    
    private class var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
        
}
