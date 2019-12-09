//
//  UIView+.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/7/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import UIKit

extension UIView {
    
    func showLoading(_ isLoading: Bool) {
        if isLoading {
            let activityView = UIActivityIndicatorView(style: .whiteLarge)
            activityView.center = self.center
            activityView.startAnimating()
            activityView.tag = 49
            
            self.addSubview(activityView)
        } else {
            for view in self.subviews {
                if view.tag == 49 {
                    view.removeFromSuperview()
                }
            }
        }
    }
    
}
