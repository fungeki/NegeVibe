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
    
    //var bannerTimer: Timer?
    
    var willChangeCategories = false
    
    //to set iterator to 0
   // var timerIterator = 0
    
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
       // let sizeTransform = CGAffineTransform(scaleX: 1, y: 0)
//        bannerOverlayView.transform = CGAffineTransform(translationX: 0, y: bannerOverlayView.frame.height).concatenating(sizeTransform)
//        bannerFeaturedMessageBtn.transform = CGAffineTransform(translationX: bannerOverlayView.frame.width, y: 0)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(MLocationManager.sharedInstance.hasAuthorization)
        MLocationManager.sharedInstance.delegate = self
        mapView.showsUserLocation = true
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !willChangeCategories{
            initialize()
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        willChangeCategories = false
    }
    func initialize() {
        //centers location
        centerMapOnLocation(location: CurrentLocation.getInstance().getLocation())
        vsc = tabBarController?.viewControllers
        searchIcon.isUserInteractionEnabled = true
        searchTableView.transform = CGAffineTransform.init(translationX: 0, y: -150)
//        if EventsLibrary.getInstance().getNumberOfEvents() == 0 {
//                //loading indicator
//                JustHUD.shared.showInView(view: self.view, withHeader: "רק דקה", andFooter: "מסיים לטעון")
//
//                //adding artwork
//                getEvents { (events) in
//                    //close loading indicator
//                    JustHUD.shared.hide()
//                    self.convertToArtworksAndDisplay(events: events)
//                    EventsLibrary.getInstance().setEvents(events)
//                }
//            } else {
//                self.convertToArtworksAndDisplay(events: EventsLibrary.getInstance().getEvents())
//        }
        EventsLibrary.getInstance().getEvents { (events) in
            JustHUD.shared.hide()
            self.convertToArtworksAndDisplay(events: events)
        }
        //print(glb_events)
    }
    
    @IBAction func categoriesOpen(_ sender: Any) {
        let categoriesController = storyboard?.instantiateViewController(withIdentifier: "categories") as! VibesViewController
       categoriesController.isModally = true
        categoriesController.delegate = self
        self.navigationController?.pushViewController(categoriesController, animated: true)
    }
    
//    @IBAction func openMenu(_ sender: Any) {
//        let menuController = storyboard?.instantiateViewController(withIdentifier: "eventMenu") as! EventMenuViewController
//    
//        self.navigationController?.pushViewController(menuController, animated: true)
//    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake{
            guard let location = CLLocationManager().location else {
                return
            }
            
            _ = MoreAnnotationCreation(coordinate: location.coordinate, title: "pizza", subtitle: "meow")
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
            let artwork = Artwork(type: type, coordinate: location, logo: model.images[0].link, event: model)
            
            eventData.append(artwork)
            
            
        }
        //adds the annotation to the map
        self.mapView.register(ArtworkView.self,
                              forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        self.mapView.addAnnotations(self.eventData)
    }
    
    //sets region
    let regionRadius: CLLocationDistance = 5000
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

        let dt = storyboard?.instantiateViewController(withIdentifier: "details") as! EventsDetailsViewController
        //put the details
        dt.fromMap = true
        dt.eventDisplay = artwork.event
        self.navigationController?.pushViewController(dt, animated: true)
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(calloutTapped(sender:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        view.removeGestureRecognizer(view.gestureRecognizers!.first!)
    }
    
    @objc func calloutTapped(sender:UITapGestureRecognizer) {
        let view = sender.view as! MKAnnotationView
        let artworkView = view as! ArtworkView
        guard let artwork = artworkView.artwork else {
            print("no artwork error")
            return
        }
        print(artwork.title!, " was clicked")
        
        let dt = storyboard?.instantiateViewController(withIdentifier: "details") as! EventsDetailsViewController
        //put the details
        dt.fromMap = true
        dt.eventDisplay = artwork.event
        self.navigationController?.pushViewController(dt, animated: true)
        }
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

//extension EventMapViewController {
//    func mockMsg(){
//        let msg1 = FeaturedMessage(eventTitle: "אינדינגב", msgBody: "שיחה עם מיטב היוצרים, היום ב 19")
//        let msg2 = FeaturedMessage(eventTitle: "NegeVibe", msgBody: "בואו להכיר אותנו, אנחנו לא נושכים" )
//        let msg3 = FeaturedMessage(eventTitle: "האתר הרשמי", msgBody: "http://doodahackathon.herokuapp.com/" )
//        let msg4 = FeaturedMessage(eventTitle: "רן לוק", msgBody: "Lead Programmer & Server Side" )
//        let msg5 = FeaturedMessage(eventTitle: "דור צמח", msgBody: "Programmer & Lead Designer")
//        let msg6 = FeaturedMessage(eventTitle: "יבגניה קרייזמן", msgBody: "Amazing Programmer" )
//
//        let msg9 = FeaturedMessage(eventTitle: "All other contributers", msgBody: "None of this would be possible without you!" )
//        featuredMsgs = [msg1, msg2, msg3, msg4, msg5, msg6, msg9]
//    }
//
//    @objc func bannerMessageAnimation(){
//
//
//        //effect that moves the message, changes the body, returns the message
//        UIView.animate(withDuration: 0.3,delay: 0, animations: {
//            self.bannerFeaturedMessageBtn.transform = CGAffineTransform(translationX: 0, y: self.bannerFeaturedMessageBtn.frame.size.height)
//        }) { (true) in
//            self.displayFeaturedBanners(self.featuredMsgs[self.timerIterator])
//            UIView.animate(withDuration: 0.3, delay: 1, usingSpringWithDamping: 0.6, initialSpringVelocity: 10, options: [], animations: {
//                self.bannerFeaturedMessageBtn.transform = CGAffineTransform.identity
//            })
//        }
//
//        timerIterator += 1
//
//        //resets iterator to prevent out of bound
//        if timerIterator == featuredMsgs.count{
//            timerIterator = 0
//        }
//    }
//
//    func displayFeaturedBanners(_ message: FeaturedMessage){
//        bannerEventNameLabel.text = message.eventTitle
//        bannerFeaturedMessageBtn.setTitle(message.msgBody, for: .normal)
//    }
//}

extension EventMapViewController: VibesViewControllerDelegate{
    func categoriesSelected(value: [Event]) {
        for annotation in mapView.annotations where annotation is Artwork {
            mapView.removeAnnotation(annotation)
        }
        willChangeCategories = true
        //mapView.removeAnnotations(eventData)
        eventData = []
        print(value)
        convertToArtworksAndDisplay(events: value)
        
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
