//
//  EventTableViewCell.swift
//  NegeVibe
//
//  Created by  on 16.12.2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var eventUIImageView: UIImageView!
    @IBOutlet weak var locationEventLable: UILabel!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var monthLable: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    var event: Event?
    var isLiked = false
    var tabBar: UITabBarController?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        eventUIImageView.layer.cornerRadius = 20
        // Initialization code
    }
    
    @IBAction func likeButton(_ sender: UIButton) {
        guard let event = event else {
            print("no event")
            return
        }
        let userDefaults = UserDefaults.standard
        let eventID = String(event.id)
        if !isLiked{
        userDefaults.setValue(true, forKey: eventID)
        showToast(message: "האירוע נוסף למועדפים", view: self.superview!, delay: 0.5, image: UIImage(named: "ic_like_full")!)
        likeBtn.setImage(UIImage(named: "ic_like_full"), for: .normal)
        } else {
            userDefaults.setValue(false, forKey: eventID)
            showToast(message: "האירוע נמחק מהמועדפים", view: self.superview!, delay: 0.5, image: UIImage(named: "ic_like_empty_circle")!)
            likeBtn.setImage(UIImage(named: "ic_like_empty_circle"), for: .normal)
        }
    }
    
    @IBAction func chatButton(_ sender: UIButton) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
}
