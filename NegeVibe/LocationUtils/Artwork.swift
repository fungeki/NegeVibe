//
//  Artwork.swift
//  NegeVibe
//
//  Created by Ran Loock on 29/11/2018.
//  Copyright © 2018 test. All rights reserved.
//

import MapKit
import SDWebImage

class Artwork: NSObject, MKAnnotation {
    var title: String?
    var locationName: String
    var discipline: String
    var coordinate: CLLocationCoordinate2D
    var logo: String?
    var event: Event
    
    init(type discipline: String, coordinate: CLLocationCoordinate2D, logo: String?, event: Event) {
//        self.title = title
//        self.locationName = locationName
//        self.discipline = discipline
//        self.coordinate = coordinate
//        self.logo = logo
        self.event = event
        self.title = event.title
        self.locationName = event.locationname
        self.discipline = discipline
        self.coordinate = coordinate
        self.logo = logo

        super.init()
    }
    
//    init?(with events: [Event]){
//        for event in events{
//            self.title = event.title
//            self.locationName = event.locationname
//            self.discipline = Symbol(withInt: event.type)!.rawValue
//            self.locationName = event.locationname
//            self.coordinate = CLLocationCoordinate2D(latitude: event.longitude, longitude: event.latitude)
//            
//            
//        }
        
        
//    }
    
    var subtitle: String? {
        return locationName
    }
}

class ArtworkView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let artwork = newValue as? Artwork else {return}
            self.artwork = artwork

            canShowCallout = true
            
            calloutOffset = CGPoint(x: -5, y: 5)
            
            
            let imageForArtwork = Symbol(rawValue: artwork.discipline)?.getPin() ?? UIImage(named: "festival")!
            image = imageForArtwork
            
            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero,
                                                    size: CGSize(width: 30, height: 30)))
            if let imageBtn = artwork.logo {
                let urlImg = URL(string: imageBtn)
                mapsButton.sd_setImage(with: urlImg, for: .normal)
            }
          //  mapsButton.addTarget(self, action: #selector(moveToDetails(_:)), for: .touchUpInside)
            leftCalloutAccessoryView = mapsButton
//            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
    }
    weak var artwork: Artwork?
//    weak var delegate: ArtworkViewDelegate?
//    @objc private func moveToDetails(_ sender: UIButton?){
//        guard let artwork = artwork else {
//            print("error returning artwork! corrupted data")
//            return
//        }
//        delegate?.didSelectInfo(artwork)
//
//    }
}
//protocol  ArtworkViewDelegate: class {
//    func didSelectInfo(_ artwork: Artwork)
//}
