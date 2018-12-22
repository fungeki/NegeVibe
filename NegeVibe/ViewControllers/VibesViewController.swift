//
//  VibesViewController.swift
//  NegeVibe
//
//  Created by Ran Loock on 07/12/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class VibesViewController: UIViewController {
    
    @IBOutlet weak var logo: UIImageView!
    var vibeItUpTimer: Timer?
    let effectTime: TimeInterval = 0.4
    //var iterate = 1
   // var cellSelector = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
    
    var delegate: VibesViewControllerDelegate?
    
    var isModally = false
    @IBOutlet weak var vibesCollection: UICollectionView!
    var vibes = UIImage(named: "placeholder")
    let symbols = Symbol.allCases
    //var allCases = [Symbol.allCases]
   
    override func viewDidLayoutSubviews() {
        logo.layer.cornerRadius = -20
        let screenwidth = self.view.frame.width
        vibesCollection.roundCorners(corners: [.topLeft, .topRight], radius: screenwidth / 6)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       
        if isModally{
        self.navigationController?.popViewController(animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //timer for the effect:
        vibeItUpTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(VibesViewController.bringToLife), userInfo: nil, repeats: true)
        print(symbols)
      
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //height of the content
       // let collectionCellWidth = vibesCollection.contentSize.width / 3.0 + 4
        //if the collection cells are not in the middle make them start in the middle
//        vibesCollection.contentInset.top = max((vibesCollection.frame.height - collectionCellWidth * 4 + 4) / 2, 0)
        vibesCollection.contentInset.left = 6
        vibesCollection.contentInset.top = 6
        vibesCollection.contentInset.right = 6
        
        // Do any additional setup after loading the view.
        
    }
    
    @objc func bringToLife(){
//        let daFunk = cellSelector.shuffled()
//
//        for i in 0..<iterate {
        
            
            //let cellNum = daFunk[i]
            //choose a random number between 0 and 12
            
            
            //assign a random index
            let cellNum = Int.random(in: 0..<12)
            let index = IndexPath(row: cellNum, section: 0)
            guard let cell = vibesCollection.cellForItem(at: index) else {
                return
            }
            
            //casting to vibescollectionviewcell
            let vibesCell = cell as! VibesCollectionViewCell
            
            
            
            let rand = Int.random(in: 0..<8)
            
            
            
            switch rand {
            case 0:
                fullSpinVibe(vibesCell)
            case 1:
                halfSpinVibe(vibesCell)
            case 2:
                springSizeEnlarge(vibesCell)
            case 3:
                springSizeReduce(vibesCell)
            case 4:
                flickerVibe(vibesCell)
            case 5:
                revHalfTurnVibe(vibesCell)
            case 6:
                revFullTurnVibe(vibesCell)
            default:
                resizeVibe(vibesCell)
            }
            
//        }
//        if iterate < 7 {
//            iterate = iterate + 1
//        }
    }
    
    //rotate the cell counter clockwise
    func revHalfTurnVibe(_ cell: VibesCollectionViewCell){
        UIView.animate(withDuration: effectTime, animations: {
            cell.transform = CGAffineTransform(rotationAngle: -180)
        }) { (true) in
            UIView.animate(withDuration: self.effectTime, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
    
    //rotate the cell counter clockwise
    func revFullTurnVibe(_ cell: VibesCollectionViewCell){
        UIView.animate(withDuration: effectTime, animations: {
            cell.transform = CGAffineTransform(rotationAngle: -.pi)
        }) { (true) in
            UIView.animate(withDuration: self.effectTime, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
    //flicker
    func flickerVibe(_ cell: VibesCollectionViewCell){
        UIView.animate(withDuration: effectTime, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 5, options: .autoreverse, animations: {
            cell.alpha = 0.5
            
        }) { (true) in
            UIView.animate(withDuration: self.effectTime, animations: {
                cell.alpha = 1
            })
        }
    }
    //spring size to smaller cell
    func springSizeReduce(_ cell: VibesCollectionViewCell){
        UIView.animate(withDuration: effectTime, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 5, options: .autoreverse, animations: {
            cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (true) in
            UIView.animate(withDuration: self.effectTime, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
    //spring size to larger cell
    func springSizeEnlarge(_ cell: VibesCollectionViewCell){
        UIView.animate(withDuration: effectTime, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 5, options: .autoreverse, animations: {
            cell.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { (true) in
            UIView.animate(withDuration: self.effectTime, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
    
    //spins in 1 direction
    func fullSpinVibe(_ cell: VibesCollectionViewCell){
        UIView.animate(withDuration: effectTime, animations: {
            cell.transform = CGAffineTransform(rotationAngle: .pi)
        }) { (true) in
            UIView.animate(withDuration: self.effectTime, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
    
    //spins half way and returns
    func halfSpinVibe(_ cell: VibesCollectionViewCell){
        UIView.animate(withDuration: effectTime, animations: {
            cell.transform = CGAffineTransform(rotationAngle: 180)
        }) { (true) in
            UIView.animate(withDuration: self.effectTime, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
    
    //gets bigger and then smaller
    func resizeVibe(_ cell: VibesCollectionViewCell){
        UIView.animate(withDuration: effectTime, animations: {
            cell.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { (true) in
            UIView.animate(withDuration: self.effectTime, animations: {
                cell.transform = CGAffineTransform.identity
            })
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
        return symbols.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "vibesCell", for: indexPath) as! VibesCollectionViewCell
    
        let model = symbols[indexPath.row]
        cell.vibeImage.image = model.getImage()
        cell.layer.cornerRadius = 20
        cell.categoryNameLabel.text = model.getHebrewName()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = self.view.frame.width
        let cellWidth = screenWidth / 4 + 8
        return CGSize(width: cellWidth, height: cellWidth)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //let contentHeightInset = CGFloat(symbols.count / 3) * (self.view.frame.width + 16) / 4
        let screenWidth  = self.view.frame.width
        return UIEdgeInsets(top: screenWidth / 4, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = delegate else {
            print("no delegate")
            return
        }
        
        let eventsSelect = EventsLibrary.getInstance().getEventByCategories(indexPath.item)
        delegate.categoriesSelected(value: eventsSelect)
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
