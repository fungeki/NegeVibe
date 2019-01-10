//
//  FavoritesUpdate.swift
//  NegeVibe
//
//  Created by Ran Loock on 10/01/2019.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import Firebase

func FavoritesUpdate(eventID: Int, status: Bool, completion: ((_ success: Bool) -> Void)? = nil){
    let db = Firestore.firestore()
    guard let uid = SignedInUser.getInstance().getUID() else {
        print("no user")
        return
    }
    //db.collection("users").document(uid).updateData([String(eventID): status], completion: { (err) in
    let eventStr = String(eventID)
    let amountOfFavs = SignedInUser.getInstance().getFavoritesCount()
    let eventsRef = db.collection("users").document(uid).collection("favorites").document("events")
    if amountOfFavs == 0 {
        eventsRef.setData([eventStr : status], merge: true) { (err) in
        if completion != nil{
            completion!(err == nil)
            }
        }
    }
   
}
