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
    
    init?(withInt val: Int){
        switch val {
        case 0:
            self = .festival
        case 3:
            self = .movieFestival
        default:
            self = .musicFestival
        }
    }
    
    func getImage()->UIImage{
        switch self {
        case .festival:
            return UIImage(named: "festival")!
        case .movieFestival:
            return UIImage(named: "ic_inSperishin")!
        default:
            return UIImage(named: "ic_inDnegev")!
        }
    }
    
    var description: String{
        return self.rawValue
    }
}
