//
//  GetEvents.swift
//  NegeVibe
//
//  Created by Ran Loock on 28/11/2018.
//  Copyright © 2018 test. All rights reserved.
//

import Foundation

func getEventsFromDB (completion: ((_ events: [Event])->Void)? = nil){
    let urlStr = "https://doodahackathon.herokuapp.com/eventsdb" //url to eventsDB
    guard let urlObj = URL(string: urlStr) else { //creates a URL object which is NOT optional
        print("error formatting URL")
        return
    }
    URLSession.shared.dataTask(with: urlObj) { (data, res, err) in
        DispatchQueue.main.async {
            do{
                guard let data = data else { //checks that data exists
                    print("corrupted data - returned nil")
                    return
                }
                
                //decodes events arr
                let eventsArr = try JSONDecoder.init().decode([Event].self, from: data)
                //callback:
                if let completion = completion {
                    completion(eventsArr)
                }
            }catch{
                print("error fetching data !!! :(")
                
            }
        }
    }.resume()
}
