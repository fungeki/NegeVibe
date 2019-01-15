//
//  LoadingViewController.swift
//  NegeVibe
//
//  Created by Ran Loock on 15/01/2019.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        SignedInUser.getInstance().getUser { (zift) in
            EventsLibrary.getInstance().getEvents(completion: { (zift) in
                let initialVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainTabController") as! UITabBarController
                self.present(initialVC, animated: true, completion: nil)
            })
        }
        // Do any additional setup after loading the view.
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
