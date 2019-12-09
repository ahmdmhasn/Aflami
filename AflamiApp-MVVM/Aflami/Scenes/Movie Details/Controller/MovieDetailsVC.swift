//
//  MovieDetailsVC.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/6/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import UIKit
import Cosmos
import ChameleonFramework
import SDWebImage

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
    
    @IBOutlet weak var trailersActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var castActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var reviewsActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var backgroundView: BackgroundWithImageView!
    
    // Properties 
    var presenter: MovieDetailsPresenter!
    
    var likeButton: LikeNavBarButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup like button
        likeButton = LikeNavBarButton()
        likeButton.addTarget(self, action: #selector(likeButtonTapped(_:)), for: UIControl.Event.touchUpInside)
        let likeTabBarItem = UIBarButtonItem(customView: likeButton)
        self.navigationItem.rightBarButtonItem = likeTabBarItem
        
        // Setup delegates for table & collection views
        setupTrailersTableView()
        
        setupCastCollectionView()
        
        setupReviewsCollectionView()
        
        // Setup movie and get movie details
        presenter.viewDidLoad()
    }
    
    func setupTrailersTableView() {
        trailersTableView.delegate = self
        trailersTableView.dataSource = presenter
        trailersTableView.register(UINib(nibName: "TrailersTableViewCell", bundle: nil), forCellReuseIdentifier: presenter.trailersCellID)
        trailersTableView.rowHeight = UITableView.automaticDimension
        trailersTableView.estimatedRowHeight = 50.0
    }
    
    func setupCastCollectionView() {
        castCollectionView.delegate = self
        castCollectionView.dataSource = presenter
        castCollectionView.tag = presenter.castTag
        castCollectionView.register(UINib(nibName: "CastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: presenter.castCellID)
    }
    
    func setupReviewsCollectionView() {
        reviewsCollectionView.delegate = self
        reviewsCollectionView.dataSource = presenter
        reviewsCollectionView.tag = presenter.reviewsTag
        reviewsCollectionView.register(UINib(nibName: "ReviewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: presenter.reviewCellID)
    }
        
    @objc func likeButtonTapped(_ button: LikeNavBarButton) {
        if button.isActive {
            presenter.removeMovieFromDatabase()
        } else {
            presenter.addMovieToDatabase()
        }
    }
}

extension MovieDetailsVC: MovieDetailsDelegate {
    
    func updateMovieImage(path: String) {
        movieImage.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
        let url = URL.getTMDBImage(type: .poster(path: path, size: .w342))
        movieImage.sd_setImage(with: url) { (image, error, cache, url) in
            if let image = image {
                let color = UIColor(averageColorFrom: image)
                self.navigationController?.navigationBar.barTintColor = color
                self.navigationController?.navigationBar.tintColor = UIColor(contrastingBlackOrWhiteColorOn: color, isFlat: true)
            }
        }
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
    
    func updateBackgroundView() {
        backgroundView.setup(with: movieImage.image, background: self.view.backgroundColor)
    }
    
    func shouldGetCast(done: Bool = false) {
        if done {
            castCollectionView.reloadData()
            castActivityIndicator.stopAnimating()
        } else {
            castActivityIndicator.startAnimating()
        }
    }
    
    func shouldGetTrailers(done: Bool = false) {
        if done {
            trailersTableView.reloadData()
            trailersActivityIndicator.stopAnimating()
        } else {
            trailersActivityIndicator.startAnimating()
        }
    }
    
    func shouldGetReviews(done: Bool = false) {
        if done {
            reviewsCollectionView.reloadData()
            reviewsActivityIndicator.stopAnimating()
        } else {
            reviewsActivityIndicator.startAnimating()
        }
    }
    
    func addedToFavourite(state: Bool) {
        likeButton.shouldSetActive(state)
    }
    
    
}

extension MovieDetailsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectTrailer(at: indexPath.row)
    }
    
}


extension MovieDetailsVC: UICollectionViewDelegate {
    
}
