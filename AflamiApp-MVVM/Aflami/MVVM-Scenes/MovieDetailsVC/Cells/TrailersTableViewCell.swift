//
//  TrailersTableViewCell.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/7/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import UIKit

class TrailersTableViewCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var trailerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var trailer: Trailer! {
        didSet {
            nameLabel.text = trailer.name
            descriptionLabel.text = trailer.type
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
