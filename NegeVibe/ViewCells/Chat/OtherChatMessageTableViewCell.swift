//
//  OtherChatMessageTableViewCell.swift
//  NegeVibe
//
//  Created by Ran Loock on 18/01/2019.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class OtherChatMessageTableViewCell: UITableViewCell {


    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var textBodyLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var messageWrapperView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
//        messageWrapperView.roundCorners(corners: [.topLeft, .topRight, .topLeft, .bottomRight], radius: 20)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
