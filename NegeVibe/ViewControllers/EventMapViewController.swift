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
    
    var bannerTimer: Timer?
    
    var timerIterator = 0
    
    @IBOutlet weak var bannerOverlayView: UIView!
    
    @IBOutlet weak var bannerEventNameLabel: UILabel!
    
    @IBOutlet weak var bannerFeaturedMessageBtn: UIButton!
    
    func location(_ location: CLLocation) {
        //use location to show on map:
        print(location.coordinate)
    }
    
    var featuredMsgs:[FeaturedMessage] = []

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
        let sizeTransform = CGAffineTransform(scaleX: 1, y: 0)
        bannerOverlayView.transform = CGAffineTransform(translationX: 0, y: bannerOverlayView.frame.height).concatenating(sizeTransform)
        bannerFeaturedMessageBtn.transform = CGAffineTransform(translationX: bannerOverlayView.frame.width, y: 0)
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
                UIView.animate(withDuration: 0.3, animations: {
                    self.bannerOverlayView.transform = CGAffineTransform.identity
                }) { (true) in
                    self.mockMsg()
                    self.displayFeaturedBanners(self.featuredMsgs[0])
                    self.bannerTimer = Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(self.bannerMessageAnimation), userInfo: nil, repeats: true)
                    

                    self.bannerFeaturedMessageBtn.transform = CGAffineTransform.identity
                }
            }
        } else {
            convertToArtworksAndDisplay(events: EventsLibrary.getInstance().getEvents())
        }
        
        
    }
    
    
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake{
            guard let location = CLLocationManager().location else {
                return
            }
            
            let annotation = MoreAnnotationCreation(coordinate: location.coordinate, title: "pizza", subtitle: "meow")
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
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        if annotation is ArtworkView || annotation is MKUserLocation{
//            return nil
//        }
//        let annot = mapView.dequeueReusableAnnotationView(withIdentifier: "pizza", for: annotation)
//        if annot == nil{
//            let pin = MKPinAnnotationView()
//            pin.pinTintColor = UIColor.purple
//            return pin
//        }
//        return annot
//
//    }
    
    
    
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

extension EventMapViewController {
    func mockMsg(){
        let msg1 = FeaturedMessage(eventTitle: "אינדינגב", msgBody: "שיחה עם מיטב היוצרים, היום ב 19")
        let msg2 = FeaturedMessage(eventTitle: "NegeVibe", msgBody: "בואו להכיר אותנו, אנחנו לא נושכים" )
        let msg3 = FeaturedMessage(eventTitle: "האתר הרשמי", msgBody: "http://doodahackathon.herokuapp.com/" )
        let msg4 = FeaturedMessage(eventTitle: "רן לוק", msgBody: "Lead Programmer & Server Side" )
        let msg5 = FeaturedMessage(eventTitle: "דור צמח", msgBody: "Programmer & Lead Designer")
        let msg6 = FeaturedMessage(eventTitle: "יבגניה קרייזמן", msgBody: "Amazing Programmer" )
        let msg7 = FeaturedMessage(eventTitle: "אופיר אליאס", msgBody: "Talented Designer & Awesome Programmer" )
        let msg8 = FeaturedMessage(eventTitle: "גיל דניאל", msgBody: "Entrepreneur" )
        let msg9 = FeaturedMessage(eventTitle: "All other contributers", msgBody: "None of this would be possible without you!" )
        featuredMsgs = [msg1, msg2, msg3, msg4, msg5, msg6, msg7, msg8, msg9]
    }
    
    @objc func bannerMessageAnimation(){
        timerIterator += 1
        
        //resets iterator to prevent out of bound
        if timerIterator == featuredMsgs.count{
            timerIterator = 0
        }
        
        //effect that moves the message, changes the body, returns the message
        UIView.animate(withDuration: 0.3,delay: 0, animations: {
            self.bannerFeaturedMessageBtn.transform = CGAffineTransform(translationX: self.bannerFeaturedMessageBtn.frame.size.width, y: 0)
        }) { (true) in
            self.displayFeaturedBanners(self.featuredMsgs[self.timerIterator])
            UIView.animate(withDuration: 0.3, delay: 1, usingSpringWithDamping: 0.6, initialSpringVelocity: 10, options: [], animations: {
                self.bannerFeaturedMessageBtn.transform = CGAffineTransform.identity
            })
        }
        
        
    }
    
    func displayFeaturedBanners(_ message: FeaturedMessage){
        bannerEventNameLabel.text = message.eventTitle
        bannerFeaturedMessageBtn.setTitle(message.msgBody, for: .normal)
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
