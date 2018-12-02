//
//  Images.swift
//  NegeVibe
//
//  Created by Ran Loock on 29/11/2018.
//  Copyright © 2018 test. All rights reserved.
//

import Foundation

struct EventImage: Codable, CustomStringConvertible {
    var id: Int
    var title: String
    var link: String
    var status: Int
    
    var description: String{
        return "\(title) image"
    }
}
