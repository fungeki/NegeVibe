//
//  ChatListViewController.swift
//  NegeVibe
//
//  Created by Dor tzemach on 09/01/2019.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class ChatListViewController: UIViewController {

    @IBOutlet weak var chatListUITableView: UITableView!
    
    var arrEvent = [Event]()
    var willShowTickesBooked = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        self.title = "צ׳אטים"
        chatListUITableView.rowHeight = chatListUITableView.bounds.height / 8
        // Do any additional setup after loading the view.
    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.navigationController?.navigationBar.barTintColor = getBrightOrange()
//    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = getLightBlue()
        if !willShowTickesBooked{
//            if EventsLibrary.getInstance().getNumberOfEvents() == 0{
//                JustHUD.shared.showInView(view: self.view, withHeader: "רק רגע", andFooter: "כל הצ'אטים")
////                getEvents { (arrEvent) in self.arrEvent = arrEvent
////                    JustHUD.shared.hide()
////                    EventsLibrary.getInstance().setEvents(arrEvent)
////                    self.chatListUITableView.reloadData()
////                }
//                EventsLibrary.getInstance().downloadEvents {
//                    JustHUD.shared.hide()
//                    self.chatListUITableView.reloadData()
//                }
//            } else {
//                self.arrEvent = EventsLibrary.getInstance().getEvents()
//            }
            EventsLibrary.getInstance().getEvents { (events) in
                self.arrEvent = events
                self.chatListUITableView.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        //eventImageUIImageView
        
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

extension ChatListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return arrEvent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatListCell", for: indexPath) as! ChatListTableViewCell
        
        let chatList = arrEvent[indexPath.item]
        
        cell.eventImageUIImageView.layer.cornerRadius = cell.eventImageUIImageView.frame.height / 2
        cell.eventImageUIImageView.layer.masksToBounds = true
        cell.eventImageUIImageView.clipsToBounds = true
        
        let url = URL(string: chatList.images[0].link)
        cell.eventImageUIImageView.sd_setImage(with:url)
        
        cell.eventTitleUILabel.text = chatList.title
        cell.lastMessageUILabel.text = "אכל את הכובע"
        cell.messageTimeUILabel.text = "14:30"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ChatListVC = self.storyboard?.instantiateViewController(withIdentifier: "chatForEvent") as! ChatViewController
        self.navigationController?.pushViewController(ChatListVC, animated: true)
    }
    
    
}


