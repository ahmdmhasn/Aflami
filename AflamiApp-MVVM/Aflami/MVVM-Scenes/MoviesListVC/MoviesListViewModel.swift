//
//  MoviesListViewModel.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 12/9/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import Foundation

class MoviesListViewModel {
    
    private var currentPage = 1
    private var totalCount = 0
    private var moviesList = [Movie]()
    private var category: PopularMoviesSortType = .popularity
    
    private var moviesViewModelsList = [MovieCellViewModel]() {
        didSet {
            self.reloadCollectionViewClosure?()
        }
    }
    
    var state: State = .empty {
        didSet {
            self.updateStateClosure?()
        }
    }
    
    // Closures
    var reloadCollectionViewClosure: (()->())?
    var updateStateClosure: (()->())?
        
    // MARK: - Init
    // Inject network manager/ data manager if needed
    init() {

    }
    
    // MARK: - Handlers
    
    var numberOfCells: Int {
        return moviesViewModelsList.count
    }

    func getCellViewModel(at indexPath: IndexPath) -> MovieCellViewModel {
        return moviesViewModelsList[indexPath.row]
    }
    
    func getMovie(at indexPath: IndexPath) -> Movie {
        return moviesList[indexPath.row]
    }
    
    func initFetch() {
        self.currentPage = 1
        self.totalCount = 0
        self.moviesList.removeAll()
        self.moviesViewModelsList.removeAll()
        
        getMovies(page: self.currentPage)
    }
    
    func fetchNewMovies() {
        if moviesViewModelsList.count < totalCount {
            getMovies(page: currentPage)
        }
    }
    
    func updateSortingType(to category: PopularMoviesSortType) {
        guard category != self.category else {
            self.state = .error(message: "You have to choose a different categoty!")
            return
        }
        
        self.category = category
        initFetch()
    }
    
    // MARK: - Private Handlers
    
    private func processFetchedMovies(movies: [Movie]) {
        self.moviesList.append(contentsOf: movies)
        let vms = movies.map{MovieCellViewModel(withMovie: $0)}
        self.moviesViewModelsList.append(contentsOf: vms)
    }
    
    private func getMovies(page: Int) {
        
        state = .loading
        
        NetworkManager.shared.getNewMovies(page: page, sortType: self.category) { [weak self] (apiResponse, error) in
            
            guard let self = self else { return }
            
            guard let apiResponse = apiResponse else {
                self.state = .error(message: error?.localizedDescription ?? "")
                return
            }
            
            self.currentPage += 1
            self.totalCount = apiResponse.totalResults
            
            guard !apiResponse.movies.isEmpty else {
                self.state = .empty
                return
            }
            
            self.processFetchedMovies(movies: apiResponse.movies)
            self.state = .populated
        }
    }
    
}
