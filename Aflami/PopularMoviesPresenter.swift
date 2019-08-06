//
//  PopularMoviesPresenter.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/3/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import UIKit

protocol PopularMoviesDelegate {
    func reloadCollectionView()
}

class PopularMoviesPresenter: NSObject {
    
    let moviesCellReuseIdentifier = "MoviesCollectionViewCell"
    let networkManager = NetworkManager.shared
    var moviesList = [Movie]()
    var page: Int = 1
    var delegate: PopularMoviesDelegate!
    
    func getMovies() {
        networkManager.getNewMovies(page: page) { [weak self] (movies) in
            guard let movies = movies else {
                return
            }
            
            self?.page += 1
            self?.moviesList.append(contentsOf: movies)
            self?.delegate.reloadCollectionView()
        }
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
