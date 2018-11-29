//
//  EventMapViewController.swift
//  NegeVibe
//
//  Created by Ran Loock on 29/11/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit
import MapKit
import Contacts

class EventMapViewController: UIViewController {

    //map outlet
    @IBOutlet weak var mapView: MKMapView!
    
    // set initial location in IndNegev
    let initialLocation = CLLocation(latitude: 31.2051119, longitude: 34.4533182)
    override func viewDidLoad() {
        super.viewDidLoad()
        //shifts type to hybrid
        mapView.mapType = .hybrid
        
        //to show images
        
        
        //centers location
        centerMapOnLocation(location: initialLocation)

        //loading indicator
        JustHUD.shared.showInView(view: self.view, withHeader: "Loading", andFooter: "Please Wait")
        
        //protocols to extension
    //    mapView.delegate = self
        
        
        
        //adding artwork
        getEvents { (events) in
            //close loading indicator
            JustHUD.shared.hide()
            //chosen event
            let model = events[0]
            //event location on map
            let location = CLLocationCoordinate2D(latitude: model.latitude, longitude: model.longitude)
            //type of the event by symbol
            let type = Symbol(withInt: model.type)?.rawValue ?? "unknown type"
            //create artwork for the model event
            let indNegev = Artwork(title: model.title, locationName: model.locationname, type: type, coordinate: location, logo: model.images[0].link)
//            //adds the artwork to the map
            self.mapView.register(ArtworkView.self,
                             forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
            //adds the annotation to the map
            self.mapView.addAnnotation(indNegev)
            self.mapView.reloadInputViews()
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

//extension EventMapViewController: MKMapViewDelegate {
//    // 1
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        // 2
//        guard let annotation = annotation as? Artwork else { return nil }
//        // 3
//        let identifier = "marker"
//        var view: MKMarkerAnnotationView
//  //      let imageForArtwork = Symbol(rawValue: annotation.discipline)?.getImage() ?? UIImage(named: "festival")!
//        // 4
//        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//            as? MKMarkerAnnotationView {
//            dequeuedView.annotation = annotation
////            dequeuedView.image = imageForArtwork
//            view = dequeuedView
//            
//            
//        } else {
//            // 5
//            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            view.canShowCallout = true
//            view.calloutOffset = CGPoint(x: -5, y: 5)
//            view.leftCalloutAccessoryView = UIButton(type: .detailDisclosure)
//        }
//        return view
//    }
//}
