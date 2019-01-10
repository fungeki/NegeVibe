//
//  CreateANewUser.swift
//  NegeVibe
//
//  Created by Ran Loock on 10/01/2019.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import Firebase

func createUser(){
    let uid = Auth.auth().currentUser!.uid
    let db = Firestore.firestore()
    let formatter = DateFormatter()
    //2016-12-08
    formatter.dateFormat = "dd-MM-yyyy"
    let now = Date()
    let dateString = formatter.string(from:now)
    db.collection("users").document(uid).setData(["joined": dateString])
}
