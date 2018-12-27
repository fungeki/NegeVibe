//
//  MyEventViewController.swift
//  NegeVibe
//
//  Created by Rami Tzafon on 27.12.2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class MyEventViewController: UIViewController, UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var nameOfEventTextField: UITextField!
    @IBOutlet weak var eventDataPicker: UIDatePicker!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        eventImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.imagePlaceholder(_:)))
            eventImage.addGestureRecognizer(tap)
    }
    
    @IBAction func imagePlaceholder(_ sender: UITapGestureRecognizer) {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(image,animated: true){
            
        }
    }
    

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            eventImage.image = image
        }else{
            print("error")
        }
        
        self.dismiss(animated: true, completion: nil)
        
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
