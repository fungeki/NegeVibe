//
//  FavoritesBuilders.swift
//  NegeVibe
//
//  Created by Ran Loock on 13/01/2019.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import Firebase

func FavoritesBuilder(favoriteID id: Int,completion: (()->Void)?=nil){
    let db = Firestore.firestore()
    guard let uid = SignedInUser.getInstance().getUID() else {
        print("no user")
        return
    }
    let pushID = String(id)
    db.collection("favorites").document(uid).setData([pushID: true]) { (err) in
        if let err = err {
            print("oops, must be \(err)")
            return
        }
        if let completion = completion{
            completion()
        }
    }
}
