//
//  EventTableViewController.swift
//  NegeVibe
//
//  Created by  on 16.12.2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class EventTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var eventTableView: UITableView!
    var arrEvent = [Event]()
    var willShowCategories = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    eventTableView.rowHeight = self.view.frame.height / 3
    
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !willShowCategories{
        if EventsLibrary.getInstance().getNumberOfEvents() == 0{
            JustHUD.shared.showInView(view: self.view, withHeader: "רק רגע", andFooter: "מוריד אירועים")
            getEvents { (arrEvent) in self.arrEvent = arrEvent
                JustHUD.shared.hide()
                EventsLibrary.getInstance().setEvents(arrEvent)
                self.eventTableView.reloadData()
            }
        } else {
            self.arrEvent = EventsLibrary.getInstance().getEvents()
        }
    }
    }
   
    @IBAction func openCategories(_ sender: UIBarButtonItem) {
        let categoriesController = storyboard?.instantiateViewController(withIdentifier: "categories") as! VibesViewController
        categoriesController.isModally = true
        categoriesController.delegate = self
        self.navigationController?.pushViewController(categoriesController, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrEvent.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)  as! EventTableViewCell
       
        
        let negevEvent = arrEvent[indexPath.item]

        cell.eventTitleLabel.text = negevEvent.title
        cell.locationEventLable.text = negevEvent.locationname
        let dateInput = negevEvent.date
        let formater2 = DateFormatter()
        formater2.locale = Locale(identifier: "en_US_POSIX")
        formater2.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let day = formater2.date(from: dateInput){
            formater2.locale = Locale(identifier: "he_IL")
            formater2.dateFormat = "d"
            let formattedStr = formater2.string(from: day)
            cell.dayLabel.text = formattedStr
        }
    
        let formater = DateFormatter()
        formater.locale = Locale(identifier: "en_US_POSIX")
        formater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let month  = formater.date(from: dateInput){
            formater.locale = Locale(identifier: "he_IL")
            formater.dateFormat = "MMMM"
            let formattedDate = formater.string(from: month)
            cell.monthLable.text = formattedDate
        }
        
        cell.tabBar = self.tabBarController
        cell.event = negevEvent
        let url = URL(string: negevEvent.images[0].link)
        cell.eventUIImageView.sd_setImage(with:url)
        cell.selectionStyle = .none
        let userDefaults = UserDefaults.standard
        let eventIDStr = String(negevEvent.id)
        let isEventLiked = userDefaults.bool(forKey: eventIDStr)
       // print(isEventLiked)
        if isEventLiked {
            cell.likeBtn.setImage(UIImage(named: "ic_like_full"), for: .normal)
            cell.isLiked = true
        }
        
  
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dt = storyboard?.instantiateViewController(withIdentifier: "details") as! EventsDetailsViewController
        //put the details
        dt.fromMap = true
        dt.eventDisplay = arrEvent[indexPath.row]
        self.navigationController?.pushViewController(dt, animated: true)
        
    }
    
//    func configureTableView(){
//        eventTableView.rowHeight = UITableView.automaticDimension
//        eventTableView.estimatedRowHeight = 100.0
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
extension EventTableViewController: VibesViewControllerDelegate{
    func categoriesSelected(value: [Event]) {
        arrEvent = value
        willShowCategories = true
        eventTableView.reloadData()
    }
    
    
}

