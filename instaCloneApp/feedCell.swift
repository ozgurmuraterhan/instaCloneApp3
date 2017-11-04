//
//  feedCell.swift
//  instaCloneApp
//
//  Created by Murat Erhan on 1.11.2017.
//  Copyright © 2017 Murat Erhan. All rights reserved.
//

import UIKit

class feedCell: UITableViewCell {

    @IBOutlet weak var imagesView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
