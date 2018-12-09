//
//  CustomAnnotation.swift
//  NegeVibe
//
//  Created by Ran Loock on 09/12/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit
import MapKit

class MoreAnnotationCreation: NSObject, MKAnnotation{
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
    
    override var description: String{
        return "\(title)"
    }
    
}
