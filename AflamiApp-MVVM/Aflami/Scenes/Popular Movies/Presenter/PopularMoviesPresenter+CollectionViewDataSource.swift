//
//  PopularMoviesPresenter+CollectionViewDataSource.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/10/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import UIKit

extension PopularMoviesPresenter: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return moviesList.count
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let movie = moviesList[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: moviesCellReuseIdentifier, for: indexPath) as! MoviesCollectionViewCell
        
        cell.movie = MovieCellViewModel(withMovie: movie)
        
        return cell
    }
    
    
}
