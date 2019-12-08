//
//  FavouriteMoviesVC+Presenter.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/9/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import Foundation
import SVProgressHUD

extension FavouriteMoviesVC: FavouriteMoviesVCDelegate {

    func loadMoviesStarted() {
        SVProgressHUD.show()
    }
    
    func loadMoviesFinished() {
        SVProgressHUD.dismiss()
        DispatchQueue.main.async {
            if #available(iOS 10.0, *) {
                self.moviesCollectionView.refreshControl?.endRefreshing()
            }
        }
        moviesCollectionView.reloadData()
    }
    
}
