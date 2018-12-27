//
//  TypeOfTicket.swift
//  NegeVibe
//
//  Created by Rami Tzafon on 27.12.2018.
//  Copyright © 2018 test. All rights reserved.
//

import Foundation

enum TypeOfTicket: String, CustomStringConvertible{
    case student = "Student"
    case pensioner = "Pensioner"
    case child = "Child"
    case simple = "Simple"
    
    init?(withInt val: Int){
        switch val {
        case 0:
            self = .student
        case 1:
            self = .pensioner
        case 2:
            self = .child
        default:
            self = .simple
            
        }
    }
        
    
    var description: String{
        return self.rawValue
        
    }
    
    func getHebrewName() -> String {
        switch self {
        case .student:
            return "סטודנט"
        case .pensioner:
             return "גימלאי"
        case .child:
             return "ילדֿֿ"
        case .simple:
             return "רגיל"
        }
    }
    
}
