//
//  EventMenuTableViewCell.swift
//  NegeVibe
//
//  Created by Ran Loock on 27/12/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class EventMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        descriptionLabel.numberOfLines = 1
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.minimumScaleFactor = 0.1
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
