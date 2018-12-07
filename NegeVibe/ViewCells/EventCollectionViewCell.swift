//
//  EventCollectionViewCell.swift
//  NegeVibe
//
//  Created by Dor tzemach on 01/12/2018.
//  Copyright © 2018 test. All rights reserved.
//
import UIKit
import MapKit

class EventCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var eventImageUIImageView: UIImageView!
    
    @IBOutlet weak var eventTitleUILabel: UILabel!
    
    @IBOutlet weak var eventDescriptionUILabel: UILabel!
    
    var event: Event?
    
    var tabBar: UITabBarController?
    
    @IBAction func sendToMap(_ sender: UIButton) {

        guard let event = event else{
            print("nil on event")
            return
        }
        
        let eventLocation = CLLocation(latitude: event.locx, longitude: event.locy)
        CurrentLocation.getInstance().setLocation(event: event)
        
        tabBar?.selectedIndex = 0
        
    }
    
}
