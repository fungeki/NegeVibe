//
//  CarpoolMessage.swift
//  NegeVibe
//
//  Created by Ran Loock on 07/01/2019.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation

struct CarpoolMessage: Codable {
    var id: String
    var created: String
    var senderID: String
    var senderName: String
    var from: String
    var spaces: Int
}
