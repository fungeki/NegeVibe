//
//  ChatListTableViewCell.swift
//  NegeVibe
//
//  Created by Dor tzemach on 09/01/2019.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class ChatListTableViewCell: UITableViewCell {
    @IBOutlet weak var eventTitleUILabel: UILabel!
    
    @IBOutlet weak var eventImageUIImageView: UIImageView!
    @IBOutlet weak var lastMessageUILabel: UILabel!
    @IBOutlet weak var messageTimeUILabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
