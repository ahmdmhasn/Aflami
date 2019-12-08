//
//  RoundImageView.swift
//  dryv
//
//  Created by Ahmed M. Hassan on 7/13/19.
//  Copyright © 2019 Ahmed M. Hassan. All rights reserved.
//

import UIKit

class RoundedImageView: UIImageView {

    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }

}
