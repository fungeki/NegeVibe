//
//  EventTableViewController.swift
//  NegeVibe
//
//  Created by Rami Tzafon on 16.12.2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class EventTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var eventTableView: UITableView!
    var arrEvent = [Event]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    eventTableView.rowHeight = self.view.frame.height * 0.25
    if EventsLibrary.getInstance().getNumberOfEvents() == 0{
         getEvents { (arrEvent) in self.arrEvent = arrEvent
        EventsLibrary.getInstance().setEvents(arrEvent)
         self.eventTableView.reloadData()
        }
         } else {
         self.arrEvent = EventsLibrary.getInstance().getEvents()
         }
        
        
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrEvent.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)  as! EventTableViewCell
     
        let negevEvent = arrEvent[indexPath.item]
        cell.eventTitleLabel.text = negevEvent.title
        cell.locationEventLable.text = negevEvent.locationname
        cell.tabBar = self.tabBarController
        cell.event = negevEvent
        let url = URL(string: negevEvent.images[0].link)
        cell.eventUIImageView.sd_setImage(with:url)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventTableView.deselectRow(at: indexPath, animated: true)
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

