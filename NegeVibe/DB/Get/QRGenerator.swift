//
//  QRGenerator.swift
//  NegeVibe
//
//  Created by Ran Loock on 26/12/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

func QRGenerate(width: Int, height: Int)-> URL? {
    let qrGenerate = NSUUID().uuidString.lowercased()
    let urlStr = "https://api.qrserver.com/v1/create-qr-code/?size=\(width)x\(height)&data=\(qrGenerate)"
    
    guard let urlObj = URL(string: urlStr) else {
        print("error serializing qr url")
        return nil
    }
    
    return urlObj
}
