//
//  EventsDetailsViewController.swift
//  NegeVibe
//
//  Created by Rami Tzafon on 12.12.2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class EventsDetailsViewController: UIViewController {

    @IBOutlet weak var topWrapperConstraint: NSLayoutConstraint!
    @IBOutlet var fullView: UIView!
    @IBOutlet weak var contentWrapperView: UIView!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var nameOfEvents: UILabel!
    @IBOutlet weak var dateOfEvents: UILabel!
    @IBOutlet weak var locationOfEvent: UILabel!
    @IBOutlet weak var priceOfEvent: UILabel!
    @IBOutlet weak var describtionTitleLable: UILabel!
    @IBOutlet weak var describtionOfEvent: UITextView!
    
    @IBOutlet weak var ticketsButton: UIButton!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        topWrapperConstraint.constant = eventImageView.bounds.height
        eventImageView.layer.zPosition = .greatestFiniteMagnitude
        
    }
    var fromMap = false
    
    @IBAction func buyTickets(_ sender: UIButton) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if fromMap{
            fromMap = !fromMap
            self.navigationController?.popViewController(animated: true)
        }
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
    }
    
    var lastPoint: CGFloat = 0
    @IBAction func panWrapperView(_ sender: UIPanGestureRecognizer) {
        let senderPointY = sender.location(in: self.view).y
        let currentPoint = senderPointY - self.view.center.y
        contentWrapperView.center.y = currentPoint + self.view.center.y
        if lastPoint != 0 {
            print(currentPoint - lastPoint)
            eventImageView.frame.size.height += currentPoint - lastPoint
        }
        
        lastPoint = currentPoint
        
        
        
    }
    
}
