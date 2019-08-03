//
//  PopularMoviesVC.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/3/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import UIKit

class PopularMoviesVC: UIViewController {
    
    var presenter: PopularMoviesPresenter!
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = presenter
        moviesCollectionView.collectionViewLayout = layout
        moviesCollectionView.refreshControl = refreshControl
        moviesCollectionView.register(UINib(nibName: "MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: presenter.moviesCellReuseIdentifier)
        
        
    }
    
    var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let insetLeft: CGFloat = 5.0
        let insetRight: CGFloat = 5.0
        layout.sectionInset = UIEdgeInsets(top: 10.0, left: insetLeft, bottom: 5.0, right: insetRight)
        let itemWidth = UIScreen.main.bounds.width / 2 - (insetLeft + insetRight)
        layout.itemSize = CGSize(width: itemWidth, height: 300.0)
        return layout
    }
    
    var refreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        return refreshControl
    }
    
}

extension PopularMoviesVC: UICollectionViewDelegate {
    
    
    
}

// MARL: - Handle refresh control
extension PopularMoviesVC {
    
    @objc func handleRefreshControl() {
        // Update content
        print("test")
        
        // Dismiss the refresh control.
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: { 
            self.moviesCollectionView.refreshControl?.endRefreshing()
        })
    }
}
