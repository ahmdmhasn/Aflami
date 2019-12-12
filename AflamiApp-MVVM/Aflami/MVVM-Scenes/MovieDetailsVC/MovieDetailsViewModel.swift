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
    var reloadTrailersCollectionViewClosure: (()->())?
    var updateTrailersStateClosure: (()->())?
    private var trailers = [Trailer]() {
        didSet { self.reloadTrailersCollectionViewClosure?() }
    }
    private var trailersState: State = .loading {
        didSet { self.updateTrailersStateClosure?() }
    }
    // Cast properties
    private var cast = [Cast]()
    // reviews properties
    private var reviews = [Review]()
    
    // MARK: - Init
    init(movie: Movie) {
        self.movie = movie
        
        getTrailers()
    }
    
    // MARK: - Handlers
    // Trailers
    public var trailersCount: Int {
        return trailers.count
    }
    
    public func getTrailer(at indexPath: IndexPath) -> Trailer {
        return trailers[indexPath.row]
    }
    
    private func getTrailers() {
        
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

}
