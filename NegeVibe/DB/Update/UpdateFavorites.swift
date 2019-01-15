//
//  UpdateFavorites.swift
//  NegeVibe
//
//  Created by Ran Loock on 13/01/2019.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import Firebase

func updateFavorites(uid: String, favoriteID favID: Int, status: Bool, completion: (()->Void)?=nil){
    let db = Firestore.firestore()
    let favRef = db.collection("favorites").document(uid)
    let favorite = String(favID)
    favRef.updateData([favorite: !status]) { (err) in
        if let err = err {
            print("oops, \(err) happened when we tried to add a favorite")
            return
        }
        if let completion = completion{
            completion()
        }
    }
}
