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
    
    private func downloadEvents(completion: (()->Void)?=nil){
        getEventsFromDB { (events) in
            self.events = events
            if let completion = completion {
                completion()
            }
        }
    }
    func getEvents() -> [Event]{
        return events
    }
    
    func getEvents(completion: @escaping (_ events: [Event])->Void){
        if events.count == 0 {
            downloadEvents {
                completion(self.events)
            }
        } else {
            completion(self.events)
        }
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
