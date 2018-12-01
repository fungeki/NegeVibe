//
//  EventCollectionViewController.swift
//  NegeVibe
//
//  Created by Dor tzemach on 01/12/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class EventCollectionViewController: UICollectionViewController{
    
    @IBOutlet var eventCollectionView: UICollectionView!
    
    let eventTitle = ["אינדינגב","פסטיבל האור","אקו ארט ערבה","רוכבים בהצדעה"]
    
    let eventImages: [UIImage] = [
        UIImage(named: "indinegev")!,
        UIImage(named: "pastivalHor")!,
        UIImage(named: "hakoArtHarava")!,
        UIImage(named: "rochvimBehatzdaha")!,
        
        
    ]
    
    let eventDescription = ["אינדינגב הוא פסטיבל מוזיקה ואמנות עצמאית בנגב. הפסטיבל נערך לראשונה ב-2007 ",
                            "מתנס תמר מקבל את חנוכה ביומיים של חגיגה לכלהמשפחה פסטיבל האור",
                            "חוויה לכל המשפחה ברוח אומנות, יצירה, קהילה ואקולוגיה באווירה נעימה, חופשית ",
                            "רוכבים בהצדעה – מסע אופנים למען פצועי ונכי צה’’ל . ההשתתפות כרוכה בתשלום מראש"
        
    ]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (self.collectionView.frame.size.width - 20)/2, height: self.collectionView.frame.size.height/3)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return eventTitle.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCollectionCell", for: indexPath) as! EventCollectionViewCell
    
        // Configure the cell
        
        cell.eventTitleUILabel.text = eventTitle[indexPath.item]
        cell.eventImageUIImageView.image = eventImages[indexPath.item]
        cell.eventDescriptionUILabel.text = eventDescription[indexPath.item]
        cell.eventDescriptionUILabel.numberOfLines = 4
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
