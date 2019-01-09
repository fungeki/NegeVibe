//
//  GetUserChatName.swift
//  NegeVibe
//
//  Created by Ran Loock on 09/01/2019.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import Firebase

func getUserChatName(completion: @escaping ((_ userChatName: String?)->Void)){
    let db = Firestore.firestore()
    DispatchQueue.main.async {
        guard let user = Auth.auth().currentUser else {
            return
        }
        
        let uid = user.uid
        let docRef = db.collection("users").document(uid)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                let data = document.data()
                if let result = data?["chatName"] as? String{
                    completion(result)
                }
                
                
            } else {
                completion(nil)
            }
        }
    }
}
