//
//  MovieDetailsPresenter.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/6/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import UIKit

protocol MovieDetailsDelegate: class {
    var presenter: MovieDetailsPresenter! { get set }
    func updateMovieImage(path: String)
    func updateMovieRate(value: Double)
    func updateMovieName(text: String)
    func updateMovieDescription(text: String)
    func updateMovieReleaseDate(text: String)
    func updateBackgroundView()
    func shouldGetCast(done: Bool)
    func shouldGetTrailers(done: Bool)
    func shouldGetReviews(done: Bool)
    func addedToFavourite(state: Bool)
}


class MovieDetailsPresenter: NSObject {
    
    private weak var view: MovieDetailsDelegate!
    private let interactor: MovieInteractor
    private var router: MovieDetailsVCRouter
    
    var trailers = [Trailer]()
    var cast = [Cast]()
    var reviews = [Review]()
    
    let trailersCellID = "trailersCell"
    let castCellID = "castCellID"
    let reviewCellID = "reviewCellID"
    
    let castTag = 19
    let reviewsTag = 20
    
    var movie: Movie
    
    init(movie: Movie, view: MovieDetailsDelegate, interactor: MovieInteractor, router: MovieDetailsVCRouter) {
        
        self.movie = movie
        
        self.view = view
        
        self.interactor = interactor
        
        self.router = router
    }
    
    func viewDidLoad() {
        
        updateMovieUI()
        
        getTrailers()
        
        getCast()
        
        getReviews()
    }
    
    func updateMovieUI() {
        view.updateMovieImage(path: movie.posterPath ?? "")
        view.updateMovieRate(value: movie.voteAverage ?? Double.zero)
        view.updateMovieName(text: movie.title ?? "")
        view.updateMovieDescription(text: movie.overview ?? "")
        view.updateMovieReleaseDate(text: movie.releaseDate ?? "")
        view.updateBackgroundView()
        
        let movieFromDatabase = interactor.getMovieFromDatabase(with: movie.id)
        
        view.addedToFavourite(state: (movieFromDatabase != nil))
    }
    
    func getTrailers() {
        
        view.shouldGetTrailers(done: false)
        
        interactor.getTrailers(of: movie.id) { (trailers, error) in
            
            guard let trailers = trailers else { return }
            
            self.trailers = trailers
            
            self.view?.shouldGetTrailers(done: true)
        }
    }
    
    func getCast() {
        
        view.shouldGetCast(done: false)
        
        interactor.getCast(of: movie.id) { (cast, error) in
            guard let cast = cast else { return }
            
            self.cast = cast
            
            self.view?.shouldGetCast(done: true)
        }
    }
    
    func getReviews() {
        
        view.shouldGetReviews(done: false)
        
        interactor.getReviews(of: movie.id) { (reviews, error) in
            
            guard let reviews = reviews else { return }
            
            self.reviews = reviews
            
            self.view?.shouldGetReviews(done: true)
        }
    }
    
    func addMovieToDatabase() {

        interactor.addMovieToDatabase(movie)

        view.addedToFavourite(state: true)
    }
    
    func removeMovieFromDatabase() {
        
        interactor.removeMovieFromDatabase(movie)
        
        view.addedToFavourite(state: false)
    }
    
    func didSelectTrailer(at row: Int) {
        
        let key = trailers[row].key
        
        if let url = URL(string: "http://youtube.com/watch?v=\(key)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:])
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
}
