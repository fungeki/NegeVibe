//
//  VibesCollectionViewCell.swift
//  NegeVibe
//
//  Created by Ran Loock on 07/12/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class VibesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var vibeImage: UIImageView!
       
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vibeImage.layer.cornerRadius = 20
//        vibeImage.layer.borderColor = UIColor.blue.cgColor
//        vibeImage.layer.borderWidth = 1
    }
    
   
}
