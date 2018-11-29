//
//  EventMapViewController.swift
//  NegeVibe
//
//  Created by Ran Loock on 29/11/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit
import MapKit

class EventMapViewController: UIViewController {

    //map outlet
    @IBOutlet weak var mapView: MKMapView!
    
    // set initial location in IndNegev
    let initialLocation = CLLocation(latitude: 31.2051119, longitude: 34.4533182)
    override func viewDidLoad() {
        super.viewDidLoad()
        //shifts type to hybrid
        mapView.mapType = .hybrid
        
        //centers location
        centerMapOnLocation(location: initialLocation)

        //loading indicator
        JustHUD.shared.showInView(view: self.view, withHeader: "Loading", andFooter: "Please Wait")
        //adding artwork
        getEvents { (events) in
            //close loading indicator
            JustHUD.shared.hide()
            //chosen event
            let model = events[0]
            let location = CLLocationCoordinate2D(latitude: model.latitude, longitude: model.longitude)
            let type = Symbol(withInt: model.type)?.rawValue ?? "unknown type"
            let indNegev = Artwork(title: model.title, locationName: model.locationname, type: type, coordinate: location)
            self.mapView.addAnnotation(indNegev)
        }
        
    }
    
    //sets region
    let regionRadius: CLLocationDistance = 1300
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
