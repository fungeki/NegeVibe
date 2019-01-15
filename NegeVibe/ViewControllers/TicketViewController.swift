//
//  TicketViewController.swift
//  NegeVibe
//
//  Created by Ran Loock on 28/12/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class TicketViewController: UIViewController {

    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var qrImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.title = "כרטיס כניסה"
        //self.navigationController?.title = "כרטיס כניסה"
    
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        wrapperView.layer.cornerRadius = 20
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let objURL = URL(string: "https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=sofunmuchwow")
        qrImageView.sd_setImage(with: objURL)
    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.navigationController?.popViewController(animated: true)
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
