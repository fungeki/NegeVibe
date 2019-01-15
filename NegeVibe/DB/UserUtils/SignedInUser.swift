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
    let db = Firestore.firestore()
    private var user: AnonymousUser?
    private var favorites: [Int]?
    
    private init (){
        DispatchQueue.main.async {
            
            let mUser = Auth.auth().currentUser
            if mUser != nil{
                let uid = mUser!.uid
                self.user = AnonymousUser(uid: uid, chatName: nil)
                getUserChatName(completion: { (str) in
                    self.user?.chatName = str
                    getUserFavorites(uid: uid, completion: { (favorites) in
                        self.favorites = favorites
                    })
                })
                
                print("user signed in, uuid: \(mUser!.uid)")
            } else {
                Auth.auth().signInAnonymously { (res, err) in
                    guard let uid = Auth.auth().currentUser?.uid else {
                        print("no uid")
                        return
                    }
                    self.user = AnonymousUser(uid: uid, chatName: nil)
                    createUser()                }
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
    
    func getUserFirebaseRef()->DocumentReference?{
        guard let uid = user?.uid else {
            print("failed, no user id")
            return nil
        }
        let userRef = db.collection("users").document(uid)
        return userRef
    }
    
    func addFavorite(favorite: Int, completion: (()->Void)?=nil){
        if favorites?.count == 0 || favorites == nil{
            FavoritesBuilder(favoriteID: favorite) {
                if let completion = completion{
                    self.favorites = []
                    self.favorites?.append(favorite)
                    completion()
                }
            }
        } else {
            let favStatus = favorites!.contains(favorite) ? true : false
            updateFavorites(uid: user!.uid, favoriteID: favorite, status: favStatus) {
                print("meow")
            }
        }
    }
}
