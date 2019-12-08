//
//  CornerRoundedView.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/6/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import UIKit

class CornerRoundedView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }

}
