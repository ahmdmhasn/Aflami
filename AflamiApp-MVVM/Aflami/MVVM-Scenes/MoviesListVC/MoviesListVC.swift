//
//  MoviesListVC.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 12/9/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import UIKit
import SVProgressHUD

class MoviesListVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var moviesCollectionView: UICollectionView!

    // MARK: - Properties
    fileprivate var viewModel: MoviesListViewModel = {
        return MoviesListViewModel()
    }()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()

        // Init View Model
        initVM()
        
        // Setup collection view
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        moviesCollectionView.collectionViewLayout = layout
        moviesCollectionView.register(MoviesCollectionViewCell.nib, forCellWithReuseIdentifier: MoviesCollectionViewCell.identifier)
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
    
    @objc func handleRefreshControl() {
        viewModel.initFetch()
    }
    
    private func initVM() {
        viewModel.updateStateClosure = { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch self.viewModel.state {
                case .empty:
                    SVProgressHUD.dismiss()
                    UIView.animate(withDuration: 0.3) {
                        self.moviesCollectionView.alpha = 0.0
                    }
                    
                case .error(let message):
                    SVProgressHUD.dismiss()
                    let alert = CustomAlertView(frame: self.view.bounds)
                    alert.setup(message: message, button: "Dismiss", delegate: nil)
                    self.view.addSubview(alert)

                case .loading:
                    SVProgressHUD.show()

                case .populated:
                    SVProgressHUD.dismiss()
                    if #available(iOS 10.0, *) {
                        self.moviesCollectionView.refreshControl?.endRefreshing()
                    }
                    UIView.animate(withDuration: 0.3) {
                        self.moviesCollectionView.alpha = 1.0
                    }
                }
            }
        }
        
        viewModel.reloadCollectionViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.moviesCollectionView.reloadData()
            }
        }
        
        viewModel.initFetch()
    }
    
    // MARK: - Handlers
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MoviesListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.identifier, for: indexPath) as! MoviesCollectionViewCell
        cell.movie = viewModel.getCellViewModel(at: indexPath)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row + 1) == viewModel.numberOfCells {
            viewModel.fetchNewMovies()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.getMovie(at: indexPath)
        let movieDetailsVC = MovieDetailsRouter.createView(movie: movie)
        navigationController?.pushViewController(movieDetailsVC, animated: true)
    }

    
    
}
