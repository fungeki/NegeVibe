//
//  VibesViewController.swift
//  NegeVibe
//
//  Created by Ran Loock on 07/12/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class VibesViewController: UIViewController {

    //timer for the effect:
    var vibeItUpTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(VibesViewController.bringToLife), userInfo: nil, repeats: true)
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var vibesCollection: UICollectionView!
    var vibes = UIImage(named: "placeholder")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //height of the content
        let collectionCellWidth = vibesCollection.contentSize.width / 3
        //if the collection cells are not in the middle make them start in the middle
        vibesCollection.contentInset.top = max((vibesCollection.frame.height - collectionCellWidth * 4) / 2, 0)

        
        
        // Do any additional setup after loading the view.
    }
    @objc func bringToLife(){
        let index = IndexPath(row: 1, section: 0)
        guard let cell = vibesCollection.cellForItem(at: index) else {
            return
        }
        
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        let collectionHeight = self.view.safeAreaLayoutGuide.layoutFrame.size.height
//        let collectionCellWidth = vibesCollection.contentSize.width / 3
//        topConstraint.constant = (collectionHeight - collectionCellWidth * 4) / 2.0
//        print("collection height: \(collectionHeight), collection width: \(collectionCellWidth), constraint: \(topConstraint.constant) ")
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

extension VibesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "vibesCell", for: indexPath) as! VibesCollectionViewCell
        cell.vibeImage.image = vibes
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = self.view.frame.width
        return CGSize(width: screenWidth / 3, height: screenWidth / 3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
