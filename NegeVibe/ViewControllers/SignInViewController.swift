//
//  SignInViewController.swift
//  NegeVibe
//
//  Created by Ran Loock on 06/01/2019.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func anonymousSignIn(_ sender: UIButton) {
        Auth.auth().signInAnonymously() { (authResult, error) in
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainController = storyBoard.instantiateViewController(withIdentifier: "mainTabController") as! UITabBarController
            self.present(mainController, animated: true, completion: nil)
            
            // ...
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
