//
//  CastCollectionViewCell.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/7/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var castImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var characterLabel: UILabel!
    
    var cast: Cast! {
        didSet {
            nameLabel.text = cast.name
            characterLabel.text = cast.character
            
            let url = URL.getTMDBImage(type: .profile(path: cast.profilePath, size: .w45))
            castImageView.sd_setImage(with: url, placeholderImage: UIImage.defaultUser(), options: [], completed: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.appLightGrey
        
        castImageView.contentMode = .scaleAspectFill
        castImageView.layer.cornerRadius = castImageView.bounds.width / 2
        castImageView.layer.masksToBounds = true
    }

    
}
