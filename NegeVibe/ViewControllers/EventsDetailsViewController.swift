//
//  EventsDetailsViewController.swift
//  NegeVibe
//
//  Created by Rami Tzafon on 12.12.2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class EventsDetailsViewController: UIViewController {

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var nameOfEvents: UILabel!
    @IBOutlet weak var dateOfEvents: UILabel!
    @IBOutlet weak var locationOfEvent: UILabel!
    @IBOutlet weak var priceOfEvent: UILabel!
    @IBOutlet weak var describtionTitleLable: UILabel!
    @IBOutlet weak var describtionOfEvent: UITextView!
    
    @IBOutlet weak var ticketsButton: UIButton!
    
    
    @IBAction func buyTickets(_ sender: UIButton) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        if EventsLibrary.getInstance().getNumberOfEvents() == 0 {
            getEvents { (events) in
               let model = events[0]
                let image = model.images[0].link
                let urlImage = URL(string: image)
        self.eventImageView.sd_setImage(with:urlImage,placeholderImage:UIImage(named: "placeholder"))
                
                
            
        }
        
        
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
