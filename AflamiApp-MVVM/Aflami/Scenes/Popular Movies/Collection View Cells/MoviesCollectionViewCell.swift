//
//  MoviesCollectionViewCell.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/3/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import UIKit
import ChameleonFramework
import SDWebImage

class MoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var shadowView: UIView!
    
    var movie: Movie! {
        didSet {
            titleLabel.text = movie.title
            
            let url = URL.getTMDBImage(type: .poster(path: movie.posterPath, size: .w342))
            imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), options: [], completed: nil)
            
            self.layoutIfNeeded()
            shadowView.backgroundColor = UIColor.init(gradientStyle: .topToBottom, withFrame: shadowView.frame, andColors: [UIColor.clear, UIColor(white: 0.0, alpha: 0.4), UIColor(white: 0.0, alpha: 0.6)])
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
    }

}
