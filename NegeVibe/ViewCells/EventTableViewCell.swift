//
//  EventTableViewCell.swift
//  NegeVibe
//
//  Created by Rami Tzafon on 16.12.2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var eventUIImageView: UIImageView!
    @IBOutlet weak var locationEventLable: UILabel!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var monthLable: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    var event: Event?
    var tabBar: UITabBarController?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        eventUIImageView.layer.cornerRadius = 20
        // Initialization code
    }
    
    @IBAction func likeButton(_ sender: UIButton) {
    }
    
    @IBAction func chatButton(_ sender: UIButton) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
}
