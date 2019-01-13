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
    @IBOutlet weak var categoryTextField: DropDown!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var dateImageView: UIImageView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var timeImageView: UIImageView!
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var descriptionImageView: UIImageView!
    @IBOutlet weak var appartmentImageView: UIImageView!
    @IBOutlet weak var floorTextField: UITextField!
    @IBOutlet weak var flatTextField: UITextField!
    @IBOutlet weak var priceImageView: UIImageView!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var ticketTypeImageView: UIImageView!
    @IBOutlet weak var ticketTypeTextField: DropDown!
    @IBOutlet weak var peopleCountTextField: UITextField!
    @IBOutlet weak var peopleCountImageView: UIImageView!
    
    @IBOutlet weak var freeTicketButton: UIButton!
    
    var link:URL?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        eventImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.imagePlaceholder(_:)))
            eventImage.addGestureRecognizer(tap)
        
        
        //DropDawnlist
        categoryTextField.optionArray = [Symbol.concerts.getHebrewName(),Symbol.festival.getHebrewName(),Symbol.food.getHebrewName(),Symbol.generalEvents.getHebrewName(),Symbol.movie.getHebrewName(),Symbol.music.getHebrewName(),Symbol.parties.getHebrewName(), Symbol.pubs.getHebrewName(),Symbol.sport.getHebrewName()]
      
        ticketTypeTextField.optionArray = [TypeOfTicket.child.getHebrewName(),TypeOfTicket.pensioner.getHebrewName(), TypeOfTicket.regular.getHebrewName(),TypeOfTicket.student.getHebrewName(),TypeOfTicket.vip.getHebrewName()]
        changeImage()
    }
    
    @IBAction func imagePlaceholder(_ sender: UITapGestureRecognizer) {
        let image = UIImagePickerController()
        image.delegate = self
        
        let actionSheet =  UIAlertController(title: "בחירת תמונה", message: "ביחרו את המקור של התמונה", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "מצלמה", style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                image.sourceType = .camera
                self.present(image, animated: true, completion: nil)
            } else {
                let alertController = UIAlertController.init(title: nil, message: "Device has no camera.", preferredStyle: .alert)
                
                let okAction = UIAlertAction.init(title: "Woops", style: .default, handler: {(alert: UIAlertAction!) in
                })
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "ספריית תמונות", style: .default, handler: { (action) in
            image.sourceType = UIImagePickerController.SourceType.photoLibrary
            image.allowsEditing = true
            self.present(image,animated: true){
                
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "קישור", style: .default, handler: { (action) in
            //link alert
            let modelAlert = UIAlertController(title: "קישור", message: "תשים את הקישור לתמונה", preferredStyle: .alert)
            modelAlert.addTextField(configurationHandler: { (UITextField) in
               UITextField.placeholder = "קישור"
                UITextField.textAlignment = .right
            })
            
            //cancel
            let cancelButton = UIAlertAction(title:"ביטול", style:  .cancel, handler: { (action) in
                self.dismiss(animated: true, completion:nil)
            })
            modelAlert.addAction(cancelButton)
           
            
            let allowButton = UIAlertAction(title: "אישור", style:   .default, handler: { (action) in
                guard let str = modelAlert.textFields?[0].text else{return}
                self.link = URL(string: str)
                
                self.eventImage.sd_setImage(with: self.link,placeholderImage:UIImage(named:"placeholder"))
            })
            //permission
            modelAlert.addAction(allowButton)
            self.present(modelAlert,animated: true,completion: nil)
        
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
 
    override func viewDidLayoutSubviews() {
        freeTicketButton.layer.cornerRadius = freeTicketButton.bounds.height/2
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func changeImage(){
        guard let text = categoryTextField.text, !text.isEmpty else {
            return
        }
        categoryImageView.image = UIImage(named: "add_category_100")
        
        
    }

}
