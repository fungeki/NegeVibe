//
//  AnonymousUser.swift
//  NegeVibe
//
//  Created by Ran Loock on 09/01/2019.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignedInUser{
    private var user: AnonymousUser?
    private var favorites: [Int]?
    
    private init (){
        DispatchQueue.main.async {
            let mUser = Auth.auth().currentUser
            if mUser != nil{
                getUserChatName(completion: { (str) in
                    self.user = AnonymousUser(uid: mUser!.uid, chatName: str)
                })
                
                print("user signed in, uuid: \(mUser!.uid)")
            } else {
                Auth.auth().signInAnonymously { (res, err) in
                    guard let uid = Auth.auth().currentUser?.uid else {
                        print("no uid")
                        return
                    }
                    self.user = AnonymousUser(uid: uid, chatName: nil)
                    createUser()
                }
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
    
    func getUser(completion: ((_ user: AnonymousUser?)->Void)? = nil){
        guard let completion = completion else {
            return
        }
        completion(user)
        
    }
    
    func getChatName()->String?{
        return user?.chatName
    }
    func getUID()->String?{
        return user?.uid
    }
    func getFavoritesCount() -> Int{
        return favorites?.count ?? 0
    }
}
