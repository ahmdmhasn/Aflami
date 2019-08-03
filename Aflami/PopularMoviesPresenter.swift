//
//  PopularMoviesPresenter.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/3/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import UIKit

class PopularMoviesPresenter: NSObject {
    
    let moviesCellReuseIdentifier = "MoviesCollectionViewCell"
    let moviesList = [Movie]()
    
    func getMovies() {
        
    }
    
}

// MARK: - UICollectionView data source
extension PopularMoviesPresenter: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return moviesList.count
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let movie = Movie(id: 0, posterPath: "", backdrop: "", title: "", releaseDate: "", rating: 5.5, overview: "")
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: moviesCellReuseIdentifier, for: indexPath) as! MoviesCollectionViewCell
        
        cell.movie = movie
        
        return cell
    }

    
}
