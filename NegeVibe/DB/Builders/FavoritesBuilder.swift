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
    guard let userRef = SignedInUser.getInstance().getUserFirebaseRef() else {
        print("no valid user reference")
        return
    }
    let pushID = String(id)
    
//    userRef.collection("favorites").document(pushID).setData(["isFavorite": true]) { (err) in
//        if let err = err {
//            print("oops, must be \(err)")
//            return
//        }
//        if let completion = completion{
//            completion()
//        }
//    }
}
