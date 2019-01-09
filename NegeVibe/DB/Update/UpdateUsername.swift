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

func updateUsername(_ userName: String, completion: ((_ userName: String)->Void)? = nil){
    SignedInUser.getInstance().getUser { (user) in
        let db = Firestore.firestore()
    }
    
}
