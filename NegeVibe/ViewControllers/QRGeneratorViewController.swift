//
//  QRGeneratorViewController.swift
//  NegeVibe
//
//  Created by Ran Loock on 26/12/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class QRGeneratorViewController: UIViewController {

    @IBOutlet weak var QRImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    
    @IBAction func GenerateQR(_ sender: UIButton) {
        let url = QRGenerate(width: 300, height: 300)
        
        QRImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        
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
