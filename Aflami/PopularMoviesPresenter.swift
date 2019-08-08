//
//  PopularMoviesPresenter.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/3/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import UIKit

protocol PopularMoviesDelegate: class {
    func reloadCollectionView()
}

class PopularMoviesPresenter: NSObject {
    
    private weak var view: PopularMoviesDelegate!
    private var router: PopularMoviesVCRouter
    private var interactor: MovieInteractor
    
    let moviesCellReuseIdentifier = "MoviesCollectionViewCell"
    var moviesList = [Movie]()
    var page: Int = 1
    
    private weak var networkManager: NetworkManager!
    
    init(view: PopularMoviesDelegate, router: PopularMoviesVCRouter, interactor: MovieInteractor) {

        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        getAllMovies()
    }
    
    func getAllMovies() {
        
        interactor.getAllMovies(page: page) { [weak self] (movies, error) in
            
            guard let movies = movies else {
                return
            }
            
            self?.page += 1
            self?.moviesList.append(contentsOf: movies)
            self?.view.reloadCollectionView()
        }
    }
    
    func didSelectCell(at index: Int) {
        router.navigateToMovieDetails(from: view, movie: moviesList[index], movieInteractor: interactor)
    }
    
}

// MARK: - UICollectionView data source
extension PopularMoviesPresenter: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return moviesList.count
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let movie = moviesList[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: moviesCellReuseIdentifier, for: indexPath) as! MoviesCollectionViewCell
        
        cell.movie = movie
        
        return cell
    }

    
}
