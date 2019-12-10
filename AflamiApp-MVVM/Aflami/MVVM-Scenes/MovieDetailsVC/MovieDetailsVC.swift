//
//  MovieDetailsVC.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 12/10/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import UIKit
import Cosmos

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
    
    
    // MARK: - Init
    // Injected using router
    var viewModel: MovieDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
