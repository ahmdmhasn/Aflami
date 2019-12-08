//
//  FavouriteMoviesPresenter.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/9/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import Foundation

protocol FavouriteMoviesVCDelegate: class {
    var presenter: FavouriteMoviesPresenter! { set get }
    func loadMoviesStarted()
    func loadMoviesFinished()
}


class FavouriteMoviesPresenter: NSObject {
    
    private weak var view: FavouriteMoviesVCDelegate!
    private var interactor: MovieInteractor
    private var router: FavouriteMoviesVCRouter
    
    var moviesList = [Movie]()
    
    let moviesCellReuseIdentifier = "MoviesCollectionViewCell"
    
    init(view: FavouriteMoviesVCDelegate, interactor: MovieInteractor, router: FavouriteMoviesVCRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        
        updateMovies()
        
    }
    
    func updateMovies() {
        
        view.loadMoviesStarted()
        
        guard let movies = interactor.getAllMoviesFromDatabase() else {
            return
        }
        
        moviesList.removeAll()
        
        moviesList = movies
        
        view.loadMoviesFinished()
    }
    
    func didSelectMovie(at row: Int) {
        router.navigateToMovieDetails(from: view, movie: moviesList[row], movieInteractor: interactor)
    }
}
