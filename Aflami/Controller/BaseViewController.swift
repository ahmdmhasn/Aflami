//
//  BaseViewController.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/3/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol BaseViewControllerDelegate {
    func showLoading(isLoading: Bool)
    func showError(text: String)
}

class BaseViewController: UIViewController {
    
    
}

extension BaseViewController: BaseViewControllerDelegate {
    
    func showLoading(isLoading: Bool) {
        if isLoading {
            SVProgressHUD.show(withStatus: "Loading")
        } else {
            SVProgressHUD.dismiss()
        }
    }
    
    func showError(text: String) {
        
    }
    
}
