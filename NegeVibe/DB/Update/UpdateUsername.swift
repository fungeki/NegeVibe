//
//  UpdateUsername.swift
//  NegeVibe
//
//  Created by Ran Loock on 09/01/2019.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

func updateUsername(_ userName: String){
    SignedInUser.getInstance().getUser { (user) in
        guard let uid = user?.uid else {
            print("no user")
            return
        }
        let db = Firestore.firestore()
        db.collection("users").document(uid).setData(["chatName" : userName], merge: true)
        
        
    }
    
}
