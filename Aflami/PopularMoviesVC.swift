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
        
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = presenter
        moviesCollectionView.collectionViewLayout = layout
        moviesCollectionView.register(UINib(nibName: "MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: presenter.moviesCellReuseIdentifier)
        if #available(iOS 10.0, *) {
            moviesCollectionView.refreshControl = refreshControl
        }
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.appYellow
        self.navigationController?.navigationBar.tintColor = UIColor.appDarkGrey
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let insetLeft: CGFloat = 5.0
        let insetRight: CGFloat = 5.0
        layout.sectionInset = UIEdgeInsets(top: 10.0, left: insetLeft, bottom: 5.0, right: insetRight)
        let itemWidth = UIScreen.main.bounds.width / 2 - (insetLeft + insetRight)
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth*16/9)
        return layout
    }
    
    var refreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        return refreshControl
    }
}

extension PopularMoviesVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if (indexPath.row + 1) == presenter.moviesList.count {
            presenter.getAllMovies()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectCell(at: indexPath.row)
    }
    
}

// MARK: - Handle refresh control
extension PopularMoviesVC {
    
    @objc func handleRefreshControl() {
        
        DispatchQueue.main.async {
            if #available(iOS 10.0, *) {
                self.moviesCollectionView.refreshControl?.endRefreshing()
            }
        }
    }
}

extension PopularMoviesVC: PopularMoviesDelegate {

    func reloadCollectionView() {
        self.moviesCollectionView.reloadData()
    }
    
    func didSelectCell(at index: Int) {
        
        
    }
}
