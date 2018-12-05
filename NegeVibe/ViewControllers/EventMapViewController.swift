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

    
    
    let emptyFieldErrorMessage = "אנא הכנס/י שם אירוע בחיפוש"
    let emptyFieldErrorTitle = "שדה חיפוש ריק"
    let okMessage = "בסדר"
    
    var vsc: [UIViewController]?

    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var searchIcon: UIImageView!
    //map outlet
    @IBOutlet weak var mapView: MKMapView!
    //artworks to display
    var eventData = [Artwork]()
    // set initial location in IndNegev
    let initialLocation = CLLocation(latitude: 31.5227, longitude: 34.5956)
    override func viewDidLoad() {
        super.viewDidLoad()
        //centers location
        centerMapOnLocation(location: initialLocation)
        vsc = tabBarController?.viewControllers
        searchIcon.isUserInteractionEnabled = true
        
//        print(glb_events)
        if glb_events.count == 0 {
        //loading indicator
        JustHUD.shared.showInView(view: self.view, withHeader: "Loading", andFooter: "Please Wait")

        //adding artwork
        getEvents { (events) in
            //close loading indicator
            JustHUD.shared.hide()
            self.convertToArtworksAndDisplay(events: events)
            glb_events = events
            }
        } else {
            convertToArtworksAndDisplay(events: glb_events)
        }
        
    }
    
    
    @IBAction func search(_ sender: UITapGestureRecognizer) {
       
        
        if searchField.text?.count == 0 {
            popAlert(title: emptyFieldErrorTitle, message: emptyFieldErrorMessage, okMessage:  okMessage,view: self)
        }
        guard let searchTitle = searchField.text else{
            return
        }
        if glb_events.contains(where: { $0.title.contains(searchTitle) }) && searchTitle.count > 2 {
           print(glb_events.enumerated().filter({ $0.element.title.contains(searchTitle)  }).map({ $0.element }))
        } else {
            print("1 does not exists in the array")
        }
        
        
    }
    
    func convertToArtworksAndDisplay(events: [Event]) {
        for model in events{
            //event location on map
            let location = CLLocationCoordinate2D(latitude: model.locx, longitude: model.locy)
            //type of the event by symbol
            let type = Symbol(withInt: model.type)?.rawValue ?? "unknown type"
            
            //create artwork for the model event
            let artwork = Artwork(title: model.title, locationName: model.locationname, type: type, coordinate: location, logo: model.images[0].link)
            
            
            
            eventData.append(artwork)
        }
        //adds the annotation to the map
        self.mapView.register(ArtworkView.self,
                              forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        self.mapView.addAnnotations(self.eventData)
    }
    
    //sets region
    let regionRadius: CLLocationDistance = 1300
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
extension EventMapViewController: MKMapViewDelegate {
    // 1
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let artworkView = view as! ArtworkView
        guard let artwork = artworkView.artwork else {
            print("no artwork error")
            return
        }
        print(artwork.title, " was clicked")
    }
    
    
    
    
}
