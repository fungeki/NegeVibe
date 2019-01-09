//
//  AnonymousUser.swift
//  NegeVibe
//
//  Created by Ran Loock on 09/01/2019.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignedInUser{
    private var user: AnonymousUser?
    
    private init (){
        let mUser = Auth.auth().currentUser
        if mUser != nil{
            user = AnonymousUser(uid: mUser!.uid)
        } else {
            Auth.auth().signInAnonymously { (res, err) in
                guard let uid = Auth.auth().currentUser?.uid else {
                    print("no uid")
                    return
                }
                print(res)
                print("successfully signed in")
                print("uid: \(uid)")
                self.user = AnonymousUser(uid: uid)
            }
        }
    }
    
    
    private static var sharedInstance:SignedInUser!
    
    
    //creates and instance if one doesnt exist.
    static func getInstance()->SignedInUser{
        if sharedInstance == nil{
            sharedInstance = SignedInUser()
        }
        return sharedInstance
    }
    
    func getUser() -> AnonymousUser?{
        return user
    }
}
