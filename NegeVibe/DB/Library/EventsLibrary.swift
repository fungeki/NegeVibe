//
//  EventsLibrary.swift
//  NegeVibe
//
//  Created by Ran Loock on 06/12/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class EventsLibrary {
    
    private var events = [Event]()
    
    private init (){
    }
    
    
    private static var sharedInstance:EventsLibrary!
    
    
    //creates and instance if one doesnt exist.
    static func getInstance()->EventsLibrary{
        if sharedInstance == nil{
            sharedInstance = EventsLibrary()
        }
        return sharedInstance
    }
    
    func setEvents(_ events: [Event]){
        self.events = events
    }
    
    func getNumberOfEvents() -> Int{
        return events.count
    }
    
    func getEvents() -> [Event]{
        return events
    }
}
