//
//  FavouriteMoviesVC.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/9/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import UIKit

class FavouriteMoviesVC: BaseViewController {
    
    // Outlets
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    internal var presenter: FavouriteMoviesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Favourite Movies"
        
        // TODO: - Remove this to creation part
        let router = FavouriteMoviesVCRouter()
        let interactor = MovieInteractor()
        presenter = FavouriteMoviesPresenter(view: self, interactor: interactor, router: router)
        
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.appYellow
        self.navigationController?.navigationBar.tintColor = UIColor.appDarkGrey
        self.navigationController?.navigationBar.isTranslucent = false
        
        presenter.updateMovies()
    }
    
    func setupCollectionView() {
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = presenter
        moviesCollectionView.collectionViewLayout = layout
        moviesCollectionView.register(UINib(nibName: "MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: presenter.moviesCellReuseIdentifier)
        if #available(iOS 10.0, *) {
            moviesCollectionView.refreshControl = refreshControl
        }
    }
    
    var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let insetLeft: CGFloat = 5.0
        let insetRight: CGFloat = 5.0
        layout.sectionInset = UIEdgeInsets(top: 10.0, left: insetLeft, bottom: 5.0, right: insetRight)
        let itemWidth = UIScreen.main.bounds.width / 2 - (insetLeft + insetRight)
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth*275/185)
        return layout
    }
    
    var refreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        return refreshControl
    }
    
    @objc func handleRefreshControl() {
        presenter.updateMovies()
    }
    
}
