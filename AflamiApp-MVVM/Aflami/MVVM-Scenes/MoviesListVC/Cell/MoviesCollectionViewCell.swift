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
    
    public static var identifier: String = {
        return "\(MoviesCollectionViewCell.self)"
    }()
    
    public static var nib: UINib = {
        return UINib(nibName: "\(MoviesCollectionViewCell.self)", bundle: nil)
    }()

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var shadowView: UIView!
    
    var movie: MovieCellViewModel! {
        didSet {
            // Add text
            titleLabel.text = movie.title
            // Setup image
            imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imageView.sd_setImage(with: movie.url, placeholderImage: UIImage(named: "placeholder"), options: [], completed: nil)
            // Layout views
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
