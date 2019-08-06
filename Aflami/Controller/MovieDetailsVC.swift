//
//  MovieDetailsVC.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/6/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import UIKit
import Cosmos

protocol MovieDetailsDelegate {
    func updateMovieImage(image: UIImage)
    func updateMovieRate(value: Double)
    func updateMovieName(text: String)
    func updateMovieDescription(text: String)
    func updateMovieReleaseDate(text: String)
    func reloadCast()
    func reloadTrailers()
    func reloadReviews()
}

class MovieDetailsVC: BaseViewController {
    
    // Outlets
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieRateView: CosmosView!
    
    @IBOutlet weak var movieNameLabel: UILabel!
    
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var languageLabel: UILabel!
    
    @IBOutlet weak var castCollectionView: UICollectionView!
    
    @IBOutlet weak var trailersTableView: UITableView!
    
    @IBOutlet weak var reviewsCollectionView: UICollectionView!
    
    // Properties 
    var presenter: MovieDetailsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.delegate = self
        
        trailersTableView.delegate = self
        trailersTableView.dataSource = presenter
        
        presenter.updateMovieUI()
        
        presenter.getTrailers {
            
            
        }
    }
    

}

extension MovieDetailsVC: MovieDetailsDelegate {
    
    func updateMovieImage(image: UIImage) {
        movieImage.image = image
    }
    
    func updateMovieRate(value: Double) {
        movieRateView.rating = value / 2
    }
    
    func updateMovieName(text: String) {
        movieNameLabel.text = text
    }
    
    func updateMovieDescription(text: String) {
        movieDescriptionLabel.text = text
    }
    
    func updateMovieReleaseDate(text: String) {
        releaseDateLabel.text = text
    }
    
    func reloadCast() {
        castCollectionView.reloadData()
    }
    
    func reloadTrailers() {
        trailersTableView.reloadData()
    }
    
    func reloadReviews() {
        reviewsCollectionView.reloadData()
    }
    
}

extension MovieDetailsVC: UITableViewDelegate {
    
    
    
}


