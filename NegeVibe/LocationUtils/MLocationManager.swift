//
//  MLocationManager.swift
//  NegeVibe
//
//  Created by Ran Loock on 09/12/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit
import CoreLocation

class MLocationManager: NSObject {
    
    
    private let popTitle = "בקשת רשות לשרותי מיקום"
    private let popBbody = "בכדי להשתמש בשרותי מיקום והכוונה, ולקבל חוויה מלאה, נא אשר שימוש בשרותי מפה"
    private override init(){
        super.init()
        lm.delegate = self
    }
    
    public static var sharedInstance = MLocationManager()
    
    let lm = CLLocationManager()
    
    //Delegate:
    var delegate: MLocationManagerDelegate?
    
    //protocol,
    //delegate var,
    //use / notify the delegate,
    //register a viewcontroller as delegate
    
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
    
    func requestLocationUpdates(){
        lm.desiredAccuracy = kCLLocationAccuracyBest
        
        lm.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //
        switch status {
        case  .restricted, .denied:
           
            let alert = UIAlertController(title: popTitle, message: popBbody, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "בסדר", style: .default, handler: { (action) in
                guard let url = URL(string: UIApplication.openSettingsURLString) else {
                    print("no settings")
                    //ask app delegate which view controller is shown
                    
                    return
                }
                UIApplication.shared.open(url, options: [:])
                    alert.dismiss(animated: true)
                }))
            alert.addAction(UIAlertAction(title: "לא מאשר", style: .destructive, handler: { (action) in
                
                
                print("bad :(")
                alert.dismiss(animated: true)
            }))
            let window = UIApplication.shared.keyWindow?.rootViewController
            
            window?.present(alert, animated: true, completion: nil)
       
        case .notDetermined:
             manager.requestAlwaysAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
//            lm.requestLocation()
            requestLocationUpdates()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        DispatchQueue.main.async {[weak self] in
            self?.delegate?.location(locations.first!)
            
        }
    }
}


protocol MLocationManagerDelegate {
    func location(_ location: CLLocation)
    
}
