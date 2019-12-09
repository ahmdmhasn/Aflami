//
//  MovieInteractor.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/8/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import Foundation



class MovieInteractor {
    
    private var networkManager: NetworkManager!
    
    private var dataManager: DataManager!
    
    init() {

        self.networkManager = NetworkManager.shared
        
        do {
            try self.dataManager = DataManager()
        } catch {
            print("Error creating data manager \(error)")
        }
    }
    
    func getAllMovies(page: Int, sortType: PopularMoviesSortType, completion: @escaping ([Movie]?, Error?)->()) {
        
        networkManager.getNewMovies(page: page, sortType: sortType) { (movies, error) in
            
            completion(movies?.movies, error)
            
        }
    }
    
    func getTrailers(of movieId: Int, completion: @escaping ([Trailer]?, Error?)->()) {
        
        networkManager.getTrailers(movieId: movieId) { (trailers, error) in
            
            completion(trailers, error)
        }
    }
    
    func getCast(of movieId: Int, completion: @escaping ([Cast]?, Error?)->()) {

        networkManager.getCast(movieId: movieId) { (cast, error) in
            
            completion(cast, error)
        }
    }
    
    func getReviews(of movieId: Int, completion: @escaping ([Review]?, Error?)->()) {
        
        networkManager.getReviews(movieId: movieId) { (reviews, error) in

            completion(reviews, error)
        }
    }
    
    func addMovieToDatabase(_ movie: Movie) {
        
        try? dataManager.write { (transaction) in
            
            transaction.add(movie.managedObject(), update: false)
            
        }
        
        
    }
    
    func removeMovieFromDatabase(_ movie: Movie) {
        
        let movieToDelete = dataManager.object(MovieObject.self, key: movie.id)
        
        try? dataManager.write({ (transaction) in
            
            guard let movieToDelete = movieToDelete else { return }
            
            transaction.delete(movieToDelete)
        })
    }
    
    func getMovieFromDatabase(with id: Int) -> Movie? {
        
        let movieObject = dataManager.object(MovieObject.self, key: id)
        
        guard let movie = movieObject else { return nil }
        
        return Movie(managedObject: movie)
        
    }
    
    func getAllMoviesFromDatabase() -> [Movie]? {

        return dataManager.objects(MovieObject.self)?.map({ Movie(managedObject: $0) })
    }
 
}
