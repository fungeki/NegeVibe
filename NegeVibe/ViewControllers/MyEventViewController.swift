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
        
        let actionSheet =  UIAlertController(title: "בחירת תמונה", message: "ביחרו את המקור של התמונה", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "מצלמה", style: .default, handler: { (action) in
            image.sourceType = .camera
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.present(image, animated: true, completion: nil)
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "ספריית תמונות", style: .default, handler: { (action) in
            image.sourceType = UIImagePickerController.SourceType.photoLibrary
            image.allowsEditing = true
            self.present(image,animated: true){
                
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "קישור", style: .default, handler: { (action) in
        }))
        actionSheet.addAction(UIAlertAction(title: "ביטול", style: .cancel, handler: { (action) in
        }))
        
        self.present(actionSheet, animated: true) {
            
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
