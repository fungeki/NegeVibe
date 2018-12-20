//
//  EventsDetailsViewController.swift
//  NegeVibe
//
//  Created by Rami Tzafon on 12.12.2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialFlexibleHeader

class EventsDetailsViewController: UIViewController {

    @IBOutlet weak var scrollViewTopConstraint: NSLayoutConstraint!
    
    var eventDisplay: Event?

    @IBOutlet weak var eventDateLabel: UILabel!
    var startScrollPointY: CGFloat = 0
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var fullView: UIView!
    @IBOutlet weak var nameOfEvents: UILabel!
    @IBOutlet weak var describtionTitleLable: UILabel!
    @IBOutlet weak var describtionOfEvent: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ticketsButton: UIButton!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
//        scrollViewTopConstraint.constant = eventImageView.bounds.height - 20
        scrollView.layer.cornerRadius = 20
        startScrollPointY = scrollView.center.y
         ticketsButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        ticketsButton.layer.cornerRadius = ticketsButton.frame.size.height / 2
        
        
    }
    
    let headerViewController = MDCFlexibleHeaderViewController()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        addChild(headerViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addChild(headerViewController)
    }
    var fromMap = false
    
    @IBAction func share(_ sender: UIButton) {
        let text = "This is the text...."
        let image = UIImage(named: "ic_date")
        let shareAll: [Any] = [text , image!]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
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
        if let eventDisplay = eventDisplay {
            nameOfEvents.text = eventDisplay.title
            eventDateLabel.text = eventDisplay.datedescription
            locationLabel.text = eventDisplay.locationname
            describtionOfEvent.text = eventDisplay.description
          //  let screenWidth = self.view.frame.width
            let screenHeight = self.view.frame.height
            let imageURL = URL(string: eventDisplay.images[0].link)
            //headerViewController.headerView.minMaxHeightIncludesSafeArea = false
            headerViewController.headerView.maximumHeight = screenHeight * 0.2
            headerViewController.headerView.minimumHeight = 0
            let imageView = UIImageView(image: UIImage(named: "placeholder"))
            imageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"))
           // eventImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"))
            
            
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.backgroundColor = UIColor.white
            headerViewController.view.frame = view.bounds
            view.addSubview(headerViewController.view)
            headerViewController.didMove(toParent: self)
            headerViewController.headerView.trackingScrollView = scrollView
            scrollView.delegate = headerViewController
            imageView.frame = headerViewController.headerView.bounds
            imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            headerViewController.headerView.contentView.insertSubview(imageView, at: 0)
        }
        // Do any additional setup after loading the view.
    }
    
    
//    var lastPoint: CGFloat = 0
//    @IBAction func panWrapperView(_ sender: UIPanGestureRecognizer) {
//        let senderPointY = sender.location(in: self.view).y
//        let currentPoint = senderPointY - self.view.center.y
//        let delta = currentPoint - lastPoint
//        let totalDelta = scrollView.center.y - startScrollPointY
//        print(totalDelta)
//        
//        //
//        if lastPoint != 0 && (totalDelta <= 100 || delta < 0){
//            eventImageView.frame.size.height += delta
//            scrollView.center.y += delta
//        }
//        
//        lastPoint = currentPoint
//        if sender.state == .ended {
//            lastPoint = 0
//        }
//    }
    
}
