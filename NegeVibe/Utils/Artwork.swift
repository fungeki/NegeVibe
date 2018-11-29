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
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    let logo: String?
    
    init(title: String, locationName: String, type discipline: String, coordinate: CLLocationCoordinate2D, logo: String?) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        self.logo = logo
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}

class ArtworkView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let artwork = newValue as? Artwork else {return}
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            
            
            let imageForArtwork = Symbol(rawValue: artwork.discipline)?.getImage() ?? UIImage(named: "festival")!
            image = imageForArtwork
            
            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero,
                                                    size: CGSize(width: 30, height: 30)))
            if let imageBtn = artwork.logo {
                let urlImg = URL(string: imageBtn)
                mapsButton.sd_setImage(with: urlImg, for: .normal)
            }
            
            leftCalloutAccessoryView = mapsButton
        }
    }
}
