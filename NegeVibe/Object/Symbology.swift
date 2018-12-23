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
    case films = "Films"
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
            self = .films
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
    
    
    
    func getImage()->UIImage{
        switch self {
        case .festival:
            return UIImage(named: "festival")!
        case .food:
            return UIImage(named: "pin_movie_festival")!
        case .sport:
            return UIImage(named: "pin_city_event")!
        case .music:
            return UIImage(named: "pin_shows")!
        case .generalEvents:
            return UIImage(named: "pin_other")!
        case .concerts:
            return UIImage(named: "pin_religion_event")!
        case .films:
            return UIImage(named: "pin_rock_festival")!
        case .pubs:
            return UIImage(named: "pin_music_festival")!
        default:
            return UIImage(named: "pin_other")!
        }
    }
    
    var description: String{
        return self.rawValue
    }
    
    func getHebrewName() -> String {
        switch self {
        case .festival:
            return "פסטיבלים"
        case .films:
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


