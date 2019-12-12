//
//  ReviewsCollectionViewCell.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/7/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import UIKit

class ReviewsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var authorImageView: UIImageView!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var contentTextView: UITextView!
    
    var review: Review! {
        didSet {
            authorLabel.text = review.author
            contentTextView.text = review.content
            authorImageView.image = UIImage.defaultUser()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        contentTextView.layer.cornerRadius = 10
        
        authorImageView.layer.cornerRadius = authorImageView.bounds.width / 2
        
    }

}
