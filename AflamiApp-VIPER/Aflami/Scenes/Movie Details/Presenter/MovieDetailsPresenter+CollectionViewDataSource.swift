//
//  MovieDetailsPresenter+CollectionViewDataSource.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/10/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import UIKit

extension MovieDetailsPresenter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case castTag:
            return cast.count
        case reviewsTag:
            return reviews.count
        default:
            fatalError("Collection view doesn't exist!")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.tag {
        case castTag:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: castCellID, for: indexPath) as! CastCollectionViewCell
            cell.cast = cast[indexPath.row]
            return cell
        case reviewsTag:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewCellID, for: indexPath) as! ReviewsCollectionViewCell
            cell.review = reviews[indexPath.row]
            return cell
        default:
            fatalError("Collection view doesn't exist!")
        }
        
    }
}

