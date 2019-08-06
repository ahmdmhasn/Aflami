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
        
        presenter.delegate = self
        
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = presenter
        moviesCollectionView.collectionViewLayout = layout
        if #available(iOS 10.0, *) {
            moviesCollectionView.refreshControl = refreshControl
        }
        moviesCollectionView.register(UINib(nibName: "MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: presenter.moviesCellReuseIdentifier)
        
        presenter.getMovies()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "showDetailsFromPopular":
            var vc = segue.destination as? MovieDetailsVC
            let indexPath = moviesCollectionView.indexPathsForSelectedItems!.first
            let presenter = MovieDetailsPresenter(movie: self.presenter.moviesList[indexPath!.row])
            vc?.presenter = presenter
        default:
            fatalError("Identifier doesn't exist")
        }
    }
}

extension PopularMoviesVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if (indexPath.row + 1) == presenter.moviesList.count {
            presenter.getMovies()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showDetailsFromPopular", sender: self)
        
    }
    
}

// MARK: - Handle refresh control
extension PopularMoviesVC {
    
    @objc func handleRefreshControl() {
        // Update content
//        presenter.getMovies()
        
        // Dismiss the refresh control.
        
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
}
