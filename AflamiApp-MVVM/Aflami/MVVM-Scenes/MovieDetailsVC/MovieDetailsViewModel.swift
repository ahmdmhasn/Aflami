//
//  MovieDetailsViewModel.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 12/10/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import Foundation

class MovieDetailsViewModel {
    
    // MARK: - Properties
    var movie: Movie!
    // Trailers properties
    var reloadTrailersClosure: (()->())?
    var updateTrailersStateClosure: (()->())?
    private var trailers = [Trailer]() {
        didSet { self.reloadTrailersClosure?() }
    }
    public var trailersState: State = .loading {
        didSet { self.updateTrailersStateClosure?() }
    }
    // Cast properties
    var reloadCastClosure: (()->())?
    var updateCastStateClosure: (()->())?
    private var cast = [Cast]() {
        didSet { self.reloadCastClosure?() }
    }
    public var castState: State = .loading {
        didSet { self.updateCastStateClosure?() }
    }
    // reviews properties
    private var reviews = [Review]()
    
    // MARK: - Init
    init(movie: Movie) {
        self.movie = movie
    }
    
    // MARK: - Handlers
    // Trailers
    public var trailersCount: Int {
        return trailers.count
    }
    
    public func getTrailer(at indexPath: IndexPath) -> Trailer {
        return trailers[indexPath.row]
    }
    
    func loadTrailers() {
        self.trailersState = .loading
        NetworkManager.shared.getTrailers(movieId: movie.id) { [weak self] (trailers, error) in
            guard let self = self else { return }

            guard let trailers = trailers else {
                self.trailersState = .error(message: error?.localizedDescription ?? "")
                return
            }

            if trailers.isEmpty {
                self.trailersState = .empty
            }
            else {
                self.trailers = trailers
                self.trailersState = .populated
            }
        }
    }
    
    // Cast
    public var castCount: Int {
        return cast.count
    }
    
    public func getCast(at indexPath: IndexPath) -> Cast {
        return cast[indexPath.row]
    }
    
    public func loadCast() {
        self.castState = .loading
        NetworkManager.shared.getCast(movieId: movie.id) { [weak self] (cast, error) in
            guard let self = self else { return }

            guard let cast = cast else {
                self.castState = .error(message: error?.localizedDescription ?? "")
                return
            }

            if cast.isEmpty {
                self.castState = .empty
            }
            else {
                self.cast = cast
                self.castState = .populated
            }
        }
    }

}
