//
//  LikeNavBarButton.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/7/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import UIKit

class LikeNavBarButton: UIButton {
    
    var isActive: Bool = false

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        
        self.setImage(UIImage(named: "like-0.png"), for: UIControl.State.normal)
        self.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    private func selectionAnimation(){
        self.center.y += 20
        self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        self.alpha = 0.5
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [], animations: {
            
            self.center.y -= 20
            self.transform = CGAffineTransform.identity
            self.alpha = 1
            
        }, completion: { (bool) in
            
        })
    }
    
    internal func shouldSetActive(_ state: Bool) {
        
        selectionAnimation()
        
        isActive = state
        
        let image = state ? UIImage(named: "like-1.png") : UIImage(named: "like-0.png")
        
        setImage(image, for: .normal)
    }

}
