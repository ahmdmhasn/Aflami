//
//  PopularMoviesVC.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/3/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import UIKit

class PopularMoviesVC: BaseViewController {
    
    var presenter: PopularMoviesPresenter!
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
        navigationItem.rightBarButtonItems = [changeSortTypeButton]
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.appYellow
        self.navigationController?.navigationBar.tintColor = UIColor.appDarkGrey
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    private func setupCollectionView() {
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = presenter
        moviesCollectionView.collectionViewLayout = layout
        moviesCollectionView.register(UINib(nibName: "MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: presenter.moviesCellReuseIdentifier)
        if #available(iOS 10.0, *) {
            moviesCollectionView.refreshControl = refreshControl
        }
    }
    
    private var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let insetLeft: CGFloat = 5.0
        let insetRight: CGFloat = 5.0
        layout.sectionInset = UIEdgeInsets(top: 10.0, left: insetLeft, bottom: 5.0, right: insetRight)
        let itemWidth = UIScreen.main.bounds.width / 2 - (insetLeft + insetRight)
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth*275/185)
        return layout
    }
    
    private var refreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        return refreshControl
    }
    
    private var changeSortTypeButton: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(changeSortType(_:)))
    }
    
    @objc func handleRefreshControl() {
        
        DispatchQueue.main.async {
            if #available(iOS 10.0, *) {
                self.moviesCollectionView.refreshControl?.endRefreshing()
            }
        }
    }
    
    @objc func changeSortType(_ button: UIBarButtonItem) {
        let alert = UIAlertController(title: "Change sorting type?", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Popular Movies", style: .default, handler: { [weak self] (action) in
            self?.presenter.changeSortType(to: .popularity)
        }))
        
        alert.addAction(UIAlertAction(title: "Top Rated Movies", style: .default, handler: { [weak self] (action) in
            self?.presenter.changeSortType(to: .voteAverage)
        }))
        
        alert.addAction(UIAlertAction(title: "Newly Released Movies", style: .default, handler: { [weak self] (action) in
            self?.presenter.changeSortType(to: .releaseDate)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
