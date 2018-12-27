//
//  EventMenu.swift
//  NegeVibe
//
//  Created by Ran Loock on 27/12/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

struct EventMenuItem {
    let text: String
    let icon: UIImage
}

//Singleton of Events Menu
class EventMenu{
    private var eventMenu:[EventMenuItem] = []
    
    private static var sharedInstance:EventMenu!
    
    static func shared()->EventMenu{
        if sharedInstance == nil{
            sharedInstance = EventMenu()
        }
        return sharedInstance
    }
    
    private init() {
        let menu1 = EventMenuItem(text: "כרטיסים שהוזמנו", icon: UIImage(named: "placeholder")!)
        let menu2 = EventMenuItem(text: "אירועים מועדפים", icon: UIImage(named: "placeholder")!)
        let menu3 = EventMenuItem(text: "קורא קודר", icon: UIImage(named: "placeholder")!)
        let menu4 = EventMenuItem(text: "אירועים שלי", icon: UIImage(named: "placeholder")!)
        eventMenu.append(menu1)
        eventMenu.append(menu2)
        eventMenu.append(menu3)
        eventMenu.append(menu4)
    }
    
    func getMenu() -> [EventMenuItem] {
        return eventMenu
    }
}
