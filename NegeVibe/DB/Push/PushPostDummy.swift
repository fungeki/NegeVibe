//
//  PushPostDummy.swift
//  NegeVibe
//
//  Created by Ran Loock on 05/12/2018.
//  Copyright © 2018 test. All rights reserved.
//

import Foundation

class dataSource{
    func addEvent(event: Event){
        let url = URL(string: "dummy data")!
        
        let json = try? JSONEncoder.init().encode(event)
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = json
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, res, err) in
            if let data = data {
                let r = String(data: data, encoding: String.Encoding.utf8)
                print(r)
            }
        }
    }
}
