//
//  PopularMoviesVC+Presenter.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/9/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import Foundation
import SVProgressHUD

extension PopularMoviesVC: PopularMoviesDelegate {
    
    func moviesReloadStarted() {
        SVProgressHUD.show()
    }
    
    func moviesReloadCompleted() {
        
        self.moviesCollectionView.reloadData()
        
        SVProgressHUD.dismiss()
    }
    
}
