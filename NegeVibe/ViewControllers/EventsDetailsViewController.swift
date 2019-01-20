//
//  EventsDetailsViewController.swift
//  NegeVibe
//
//  Created by  on 12.12.2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialFlexibleHeader

class EventsDetailsViewController: UIViewController {

    
    var eventDisplay: Event?

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateFormattedLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var completeDescriptionLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    
    
    var startScrollPointY: CGFloat = 0
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var fullView: UIView!
    @IBOutlet weak var nameOfEvents: UILabel!
    @IBOutlet weak var describtionTitleLable: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ticketsButton: UIButton!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
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
        
        
        
        self.title = "פרטי אירוע"
        if let eventDisplay = eventDisplay {
            let dateInput = eventDisplay.date
            let formater = DateFormatter()
            formater.locale = Locale(identifier: "en_US_POSIX")
            formater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            if let mDate = formater.date(from: dateInput){
                formater.locale = Locale(identifier: "he_IL")
                formater.dateFormat = "EEEE, MMM d, yyyy"
                let formattedStr = formater.string(from: mDate)
                dateFormattedLabel.text = formattedStr
            }
            //MLocationManager.sharedInstance.getAddressStr(longitude: eventDisplay.locx, latitude: eventDisplay.locy), completion: <#(String?) -> Void#>
            MLocationManager.sharedInstance.getAddressStr(longitude: eventDisplay.locx, latitude: eventDisplay.locy) { (str) in
                if let address = str{
                    self.addressLabel.text = address
                }else {
                    self.addressLabel.text = "מחוץ לעיר"
                }
            }
            nameOfEvents.text = eventDisplay.title
            eventDateLabel.text = eventDisplay.datedescription
            locationLabel.text = eventDisplay.locationname
            let mType = Symbol.init(withInt: eventDisplay.type
            )?.getHebrewName()
            categoryLabel.text = mType
            completeDescriptionLabel.text = eventDisplay.description
          //  let screenWidth = self.view.frame.width
            let screenHeight = self.view.frame.height
            let imageURL = URL(string: eventDisplay.images[0].link)
            headerViewController.headerView.minMaxHeightIncludesSafeArea = false
            headerViewController.headerView.maximumHeight = screenHeight * 0.3
            headerViewController.headerView.minimumHeight = 0
            let imageView = UIImageView(image: UIImage(named: "placeholder"))
            imageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"))
           // eventImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"))
            priceLabel.text = "₪ ֻ\(eventDisplay.price)"
            
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
//            imageView.backgroundColor = getPrimaryColor()
            headerViewController.view.frame = view.bounds
            headerViewController.view.backgroundColor = UIColor.white
            view.addSubview(headerViewController.view)
            headerViewController.didMove(toParent: self)
            headerViewController.headerView.trackingScrollView = scrollView
            scrollView.delegate = headerViewController
            imageView.frame = headerViewController.headerView.bounds
            imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            headerViewController.headerView.contentView.insertSubview(imageView, at: 0)
            if let navBar = self.navigationController{
                navBar.view.tintColor = UIColor.white
            }
        }
        // Do any additional setup after loading the view.
    }
    
}
