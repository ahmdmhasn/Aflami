//
//  MovieDetailsVC.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 12/10/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import UIKit
import Cosmos
import SDWebImage

class MovieDetailsVC: UIViewController {
    
    // MARK: - Outlets
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
    var likeButton: LikeNavBarButton!

    let castTag = 19
    let reviewsTag = 20

    // MARK: - Properties
    
    
    // MARK: - Init
    // Injected using router
    var viewModel: MovieDetailsViewModel!
    
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

        // Init View Model
        initVM()
        
        self.setMovieData(viewModel.movie)
    }
    
    func setupTrailersTableView() {
        trailersTableView.delegate = self
        trailersTableView.dataSource = self
        trailersTableView.register(UINib(nibName: "\(TrailersTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "\(TrailersTableViewCell.self)")
        trailersTableView.rowHeight = UITableView.automaticDimension
        trailersTableView.estimatedRowHeight = 50.0
    }
    
    func setupCastCollectionView() {
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        castCollectionView.tag = castTag
        castCollectionView.register(UINib(nibName: "\(CastCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(CastCollectionViewCell.self)")
    }
    
    func setupReviewsCollectionView() {
        reviewsCollectionView.delegate = self
        reviewsCollectionView.dataSource = self
        reviewsCollectionView.tag = reviewsTag
        reviewsCollectionView.register(UINib(nibName: "\(ReviewsCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(ReviewsCollectionViewCell.self)")
    }
    
    // View Model
    private func initVM() {
        initVCTrailers()
        initVMCast()
        initVMReviews()
        
        viewModel.loadTrailers()
        viewModel.loadCast()
    }
    
    private func initVCTrailers() {
        viewModel.reloadTrailersClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.trailersTableView.reloadData()
            }
        }
        
        viewModel.updateTrailersStateClosure = { [weak self] in
            guard let self = self else { return }
            switch self.viewModel.trailersState {
            case .empty, .error, .populated:
                self.trailersActivityIndicator.stopAnimating()
                
            case .loading:
                self.trailersActivityIndicator.startAnimating()
            }
        }
    }
    
    private func initVMCast() {
        viewModel.reloadCastClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.castCollectionView.reloadData()
            }
        }
        
        viewModel.updateCastStateClosure = { [weak self] in
            guard let self = self else { return }
            switch self.viewModel.castState {
            case .empty, .error, .populated:
                self.castActivityIndicator.stopAnimating()
                
            case .loading:
                self.castActivityIndicator.startAnimating()
            }
        }
    }
    
    private func initVMReviews() {
        
    }
        
    @objc func likeButtonTapped(_ button: LikeNavBarButton) {
        if button.isActive {
//            presenter.removeMovieFromDatabase()
        } else {
//            presenter.addMovieToDatabase()
        }
    }
    
}

// MARK: - Handlers
extension MovieDetailsVC {
    
    func updateMovieImage(path: String) {
        movieImage.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
        let url = URL.getTMDBImage(type: .poster(path: path, size: .w342))
        movieImage.sd_setImage(with: url) { [weak self] (image, error, cache, url) in
            guard let self = self else { return }
            if let image = image {
                let color = UIColor(averageColorFrom: image)
                self.navigationController?.navigationBar.barTintColor = color
                self.navigationController?.navigationBar.tintColor = UIColor(contrastingBlackOrWhiteColorOn: color, isFlat: true)
                // Update backgorund image to match poster image
                self.backgroundView.setup(with: image, background: self.view.backgroundColor)
            }
        }
    }
    
    func setMovieData(_ movie: Movie) {
        self.updateMovieImage(path: movie.posterPath ?? "")
        movieRateView.rating = (movie.voteAverage ?? Double.zero) / 2
        movieNameLabel.text = movie.title ?? ""
        movieDescriptionLabel.text = movie.overview ?? ""
        releaseDateLabel.text = movie.releaseDate ?? ""
    }
    
    func shouldGetCast(done: Bool = false) {
        if done {
            castCollectionView.reloadData()
            castActivityIndicator.stopAnimating()
        } else {
            castActivityIndicator.startAnimating()
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


// MARK: - TableView Methods

extension MovieDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.trailersCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(TrailersTableViewCell.self)", for: indexPath) as! TrailersTableViewCell
        cell.trailer = viewModel.getTrailer(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        presenter.didSelectTrailer(at: indexPath.row)
    }
    
}

// MARK: - CollectionView Methods

extension MovieDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case castTag:
            return viewModel.castCount

        case reviewsTag:
//            return reviews.count
            return 0

        default:
            fatalError("Collection view doesn't exist!")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.tag {
        case castTag:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CastCollectionViewCell.self)", for: indexPath) as! CastCollectionViewCell
            cell.cast = viewModel.getCast(at: indexPath)
            return cell
            
        case reviewsTag:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ReviewsCollectionViewCell.self)", for: indexPath) as! ReviewsCollectionViewCell
//            cell.review = reviews[indexPath.row]
            return cell
            
        default:
            fatalError("Collection view doesn't exist!")
        }
        
    }
    
}
