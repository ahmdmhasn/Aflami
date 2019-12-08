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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !Connectivity.isConnectedToInternet {
            
            let alert = CustomAlertView(frame: self.view.bounds)
            
            alert.setup(message: nil, button: "Dismiss", delegate: self)
            
            self.view.addSubview(alert)
            
            UIView.animate(withDuration: 0.3, animations: { 
                self.view.layoutIfNeeded()
            })
        }
    }
    
    var movieDetailsVC: MovieDetailsVC {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailsVC") as! MovieDetailsVC
    }
    
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

extension BaseViewController: CustomAlertViewDelegate {
    
    func dismissButtonTapped(_ button: UIButton) {
        print(#function)
    }
    
}
