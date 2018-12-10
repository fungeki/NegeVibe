//
//  CustomMessageViewCell.swift
//  NegeVibe
//
//  Created by Ofir Elias on 08/12/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class CustomMessageViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var senderUserName: UILabel!
    @IBOutlet weak var senderBody: UILabel!
    @IBOutlet weak var messageBackground: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
