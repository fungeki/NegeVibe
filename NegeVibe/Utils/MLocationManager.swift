//
//  MLocationManager.swift
//  NegeVibe
//
//  Created by Ran Loock on 09/12/2018.
//  Copyright © 2018 test. All rights reserved.
//

import Foundation
import CoreLocation

class MLocationManager: NSObject {
    
    private override init(){}
    
    public static var sharedInstance = MLocationManager()
    
    let lm = CLLocationManager()
    
    func demo() {
        //location manager
        lm.requestWhenInUseAuthorization()
    }
    
    var hasAuthorization:Bool{
        var isAuthorized = locationEnabled()
        
        let authStatus = CLLocationManager.authorizationStatus()
        
        switch authStatus {
        case .notDetermined, .restricted, .denied:
            isAuthorized = false
        case .authorizedAlways, .authorizedWhenInUse:
            isAuthorized = true
        }
        
        return isAuthorized && locationEnabled()
    }
    func locationEnabled()->Bool{
        return CLLocationManager.locationServicesEnabled()
    }
}

extension MLocationManager: CLLocationManagerDelegate{
    
}
