//
//  Symbology.swift
//  NegeVibe
//
//  Created by Ran Loock on 29/11/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

enum Symbol: String, CustomStringConvertible, CaseIterable {
    case festival = "Festival"
    case movie = "Movie"
    case music = "Music"
    case food = "Food"
    case generalEvents = "GeneralEvents"
    case concerts = "Concerts"
    case sport = "Sport"
    case pubs = "Pubs"
    case parties = "Parties"
    
    
    
    
    init?(withInt val: Int){
        switch val {
        case 0:
            self = .festival
        case 1:
            self = .movie
        case 2:
            self = .music
        case 3:
            self = .food
        case 4:
            self = .generalEvents
        case 5:
            self = .concerts
        case 6:
            self = .sport
        case 7:
            self = .parties
        default:
            self = .pubs
        }
    }
    
    func getPin()->UIImage{
        switch self {
        case .festival:
            return UIImage(named: "pin_festival")!
        case .movie:
            return UIImage(named: "pin_movies")!
        case .music:
            return UIImage(named: "pin_music")!
        case .food:
            return UIImage(named: "pin_food")!
        case .generalEvents:
            return UIImage(named: "pin_event")!
        case .concerts:
            return UIImage(named: "pin_shows")!
        case .sport:
            return UIImage(named: "pin_sport")!
        case .pubs:
            return UIImage(named: "pin_pub")!
        case .parties:
            return UIImage(named: "pin_party")!
        }
    }
    
    func getImage()->UIImage{
        switch self {
        case .festival:
            return UIImage(named: "icc_fastival")!
        case .movie:
            return UIImage(named: "icc_movie")!
        case .music:
            return UIImage(named: "icc_music")!
        case .food:
            return UIImage(named: "icc_food")!
        case .generalEvents:
            return UIImage(named: "icc_event")!
        case .concerts:
            return UIImage(named: "icc_shows")!
        case .sport:
            return UIImage(named: "icc_sport")!
        case .pubs:
            return UIImage(named: "icc_pub")!
        default:
            return UIImage(named: "icc_party")!
        }
    }
    
    var description: String{
        return self.rawValue
    }
    
    func getHebrewName() -> String {
        switch self {
        case .festival:
            return "פסטיבלים"
        case .movie:
            return "סרטים"
        case .music:
            return "מוזיקה"
        case .food:
            return "אוכל"
        case .generalEvents:
            return "אירועים"
        case .concerts:
            return "הופעות"
        case .sport:
            return "ספורט"
        case .pubs:
            return "פאב/בר"
        case .parties:
            return "מסיבות"
        }
    }
}


