//
//  GetUserFavorites.swift
//  NegeVibe
//
//  Created by Ran Loock on 13/01/2019.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import Firebase

func getUserFavorites(uid: String, completion: ((_ favorites: [Int]?)->Void)?=nil){
    let db = Firestore.firestore()
    let favoritesRef = db.collection("favorites").document(uid)
    favoritesRef.getDocument { (doc, err) in
        if let err = err{
            print("oops, seems like \(err)")
            return
        }
        if let doc = doc, doc.exists{
            let data = doc.data()
            var arr: [Int] = []
            for fav in data! as! [String: Bool]{
                if fav.value == true{
                    let favID = fav.key
                    if let favID = Int(favID){
                        arr.append(favID)
                    }
                    
                }
            }
            if let completion = completion{
                completion(arr)
            return
            }
            
        }
        
    }
    if let completion = completion{
        completion(nil)
    }
}
