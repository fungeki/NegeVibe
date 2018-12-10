//
//  Symbology.swift
//  NegeVibe
//
//  Created by Ran Loock on 29/11/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

enum Symbol: String, CustomStringConvertible {
    case festival = "Festival"
    case musicFestival = "Music Festival"
    case movieFestival = "Movies Festival"
    case rockFestival = "Rock Festival"
    case cityEvent = "City Event"
    case kosherEvent = "Kosher Event"
    case concertGeneral = "Shows General"
    case otherGeneral = "Other General"
    
    init?(withInt val: Int){
        switch val {
        case 0:
            self = .festival
        case 1:
            self = .rockFestival
        case 2:
            self = .concertGeneral
        case 3:
            self = .movieFestival
        case 4:
            self = .otherGeneral
        case 5:
            self = .kosherEvent
        case 6:
            self = .cityEvent
        default:
            self = .musicFestival
        }
    }
    
    func getImage()->UIImage{
        switch self {
        case .festival:
            return UIImage(named: "festival")!
        case .movieFestival:
            return UIImage(named: "pin_movie_festival")!
        case .cityEvent:
            return UIImage(named: "pin_city_event")!
        case .concertGeneral:
            return UIImage(named: "pin_shows")!
        case .otherGeneral:
            return UIImage(named: "pin_other")!
        case .kosherEvent:
            return UIImage(named: "pin_religion_event")!
        case .rockFestival:
            return UIImage(named: "pin_rock_festival")!
        case .musicFestival:
            return UIImage(named: "pin_music_festival")!
        default:
            return UIImage(named: "pin_other")!
        }
    }
    
    var description: String{
        return self.rawValue
    }
}
