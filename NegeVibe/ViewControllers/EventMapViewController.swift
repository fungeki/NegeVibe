//
//  EventMapViewController.swift
//  NegeVibe
//
//  Created by Ran Loock on 29/11/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Contacts

class EventMapViewController: UIViewController, MLocationManagerDelegate {
    
    
    func location(_ location: CLLocation) {
        //use location to show on map:
        print(location.coordinate)
    }
    

    var isDown = false
    
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    @IBOutlet weak var searchTableView: UITableView!
    
    let emptyFieldErrorMessage = "אנא הכנס/י שם אירוע בחיפוש"
    let emptyFieldErrorTitle = "שדה חיפוש ריק"
    let okMessage = "בסדר"
    
    var searchResult = [Event]()
    
    var vsc: [UIViewController]?

    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var searchIcon: UIImageView!
    //map outlet
    @IBOutlet weak var mapView: MKMapView!
    //artworks to display
    var eventData = [Artwork]()
    // set initial location in IndNegev
    //var initialLocation = CLLocation(latitude: 31.5227, longitude: 34.5956)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(MLocationManager.sharedInstance.hasAuthorization)
        MLocationManager.sharedInstance.delegate = self
        mapView.showsUserLocation = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialize()
    }
    
    func initialize() {
        //centers location
        centerMapOnLocation(location: CurrentLocation.getInstance().getLocation())
        vsc = tabBarController?.viewControllers
        searchIcon.isUserInteractionEnabled = true
        searchTableView.transform = CGAffineTransform.init(translationX: 0, y: -150)
        
        //print(glb_events)
        if EventsLibrary.getInstance().getNumberOfEvents() == 0 {
            //loading indicator
            JustHUD.shared.showInView(view: self.view, withHeader: "Loading", andFooter: "Please Wait")
            
            //adding artwork
            getEvents { (events) in
                //close loading indicator
                JustHUD.shared.hide()
                self.convertToArtworksAndDisplay(events: events)
                EventsLibrary.getInstance().setEvents(events)
                
            }
        } else {
            convertToArtworksAndDisplay(events: EventsLibrary.getInstance().getEvents())
        }
        
        
    }
    func closeSearch(){
        let goUpEffect = CGAffineTransform.init(translationX: 0, y: -150)
        
        UIView.animate(withDuration: 0.3) {
            self.searchTableView.transform = goUpEffect
            self.searchTableView.alpha = 0
        }
        searchResult = [Event]()
        searchTableView.reloadData()
        isDown = false
    }
    

    @IBAction func search(_ sender: UITextField) {
        guard let searchTitle = searchField.text else{
            return
        }
            self.searchResult = EventsLibrary.getInstance().getEvents().enumerated().filter({ $0.element.title.contains(searchTitle)  }).map({ $0.element })
        tableHeight.constant = CGFloat(searchResult.count * 50)
        searchTableView.reloadData()
        if !isDown && searchTitle.count > 2 {
            isDown = true
            UIView.animate(withDuration: 0.3) {
                self.searchTableView.transform = CGAffineTransform.identity
                self.searchTableView.alpha = 1
            }
        } else if isDown && searchTitle.count < 3{
            closeSearch()
        }
    }
    
    func convertToArtworksAndDisplay(events: [Event]) {
        for model in events{
            //event location on map
            let location = CLLocationCoordinate2D(latitude: model.locy, longitude: model.locx)
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
        print(artwork.title!, " was clicked")
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
    }
    
    
    
    
}

extension EventMapViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! SearchResultTableViewCell
        cell.searchTitleLabel.text = searchResult[indexPath.row].title
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEvent = searchResult[indexPath.row]
        let eventLoc = CLLocation(latitude: selectedEvent.locy, longitude: selectedEvent.locx)
        UIView.animate(withDuration: 0.3) {
            self.searchTableView.transform = CGAffineTransform.init(translationX: 0, y: -150)
            self.tableHeight.constant = 0
            self.centerMapOnLocation(location: eventLoc)
            
        }
        mapView.selectAnnotation(eventData[indexPath.row], animated: true)
        searchResult = [Event]()
        isDown = false
        CurrentLocation.getInstance().setLocation(event: selectedEvent)
        self.view.endEditing(true)
    }
    
}
//    @IBAction func search(_ sender: UITapGestureRecognizer) {
//
//        guard let searchTitle = searchField.text else{
//            popAlert(title: emptyFieldErrorTitle, message: emptyFieldErrorMessage, okMessage:  okMessage,view: self)
//            return
//        }
//        if searchTitle.count == 0 {
//            popAlert(title: emptyFieldErrorTitle, message: emptyFieldErrorMessage, okMessage:  okMessage,view: self)
//        } else {
//            self.searchResult = glb_events.enumerated().filter({ $0.element.title.contains(searchTitle)  }).map({ $0.element })
//            tableHeight.constant = CGFloat(searchResult.count * 50)
//            searchTableView.reloadData()
//
//        }
//
////        if glb_events.contains(where: { $0.title.contains(searchTitle) }) && searchTitle.count > 2 {
////
////        } else {
////            print("1 does not exists in the array")
////        }
//
//    }
