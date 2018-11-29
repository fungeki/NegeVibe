//
//  Symbology.swift
//  NegeVibe
//
//  Created by Ran Loock on 29/11/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

enum Symbol: String {
    case festival = "Festival"
    case musicFestival = "Music Festival"
    
    init?(withInt val: Int){
        switch val {
        case 0:
            self = .festival
        default:
            self = .musicFestival
        }
    }
    
    func getImage()->UIImage{
        switch self {
        case .festival:
            return UIImage(named: "festival")!
        default:
            return UIImage(named: "rock_festival")!
        }
    }
}
