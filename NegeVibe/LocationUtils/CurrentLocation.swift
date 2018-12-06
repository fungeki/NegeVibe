//
//  CurrentLocation.swift
//  NegeVibe
//
//  Created by Ran Loock on 06/12/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit
import MapKit


//singleton
class CurrentLocation {
    
    private var event: Event?
    private var currentLocation: CLLocation{
        if let event = event{
            return CLLocation(latitude: event.locx, longitude: event.locy)
        } else {
          return CLLocation(latitude: 31.5227, longitude: 34.5956)
        }
    }
    private var wasChanged: Bool
    private var eventPlace = -1
    
    //singleton snippet
    private init (){
        wasChanged = false
    }
    
    private static var sharedInstance:CurrentLocation!
    
    static func getInstance()->CurrentLocation{
        if sharedInstance == nil{
            sharedInstance = CurrentLocation()
        }
        return sharedInstance
    }
    
    func setLocation(event: Event ){
        self.event = event
        wasChanged = true
    }
    
    func getLocation()-> CLLocation{
        return currentLocation
    }
    
    func getWasChanged()->Bool{
        return wasChanged
    }
    
}
