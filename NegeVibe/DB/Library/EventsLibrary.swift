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
    
    func getEventById(_ id: Int) -> Event{
        for model in events{
            if model.id == id{
                return model
            }
        }
        return events[0]
    }
    
    func getEventByCategories(_ category: Int) -> [Event]{
        var arr: [Event] = []
        for model in events{
            if model.type == category{
                arr.append(model)
            }
        }
        return arr
    }
}
