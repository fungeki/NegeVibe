//
//  ChatViewController.swift
//  NegeVibe
//
//  Created by Ran Loock on 18/01/2019.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var chatTableView: UITableView!
    var mockupChat = [ChatMessage]()
    @IBOutlet weak var textWrapperView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let msg1 = ChatMessage(id: "", content: "מיצי?!?", created: "12:58", senderID: "מיצי הגדול", senderName: "מיצי הגדול")
        let msg2 = ChatMessage(id: "", content: " מיאו מיאו מיאו מיאו, חפרתי, מיאו מיאו, בודק איך נראות הרבה שורות מיאו, מיאו", created: "12:58", senderID: "מיצי הגדול", senderName: "מיצי איש יקר")
        let msg3 = ChatMessage(id: "", content: "איפה מיצי? מיאו", created: "12:58", senderID: "מיצי הגדול", senderName: "מיצי הזהרו מחיכויים")
        let msg4 = ChatMessage(id: "", content: "כן אני פה, די לחפור", created: "13:01", senderID: "מיצי הגדול", senderName: "מיצי")
        
        mockupChat.append(msg1)
        mockupChat.append(msg2)
        mockupChat.append(msg3)
        mockupChat.append(msg4)
        
        print(mockupChat.count)
        chatTableView.reloadData()
        self.title = "Pepo צ׳אט חתולי"
        self.navigationItem.backBarButtonItem?.title = "לצ׳אטים"
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textWrapperView.layer.cornerRadius = textWrapperView.bounds.height / 2
        
        
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.tintColor = UIColor.white
//        self.navigationController?.navigationBar.barTintColor = getLightBlue()
//    }

}
extension ChatViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockupChat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "otherChat") as! OtherChatMessageTableViewCell
        let model = mockupChat[indexPath.row]
        cell.userNameLabel.text = model.senderName
        cell.timeLabel.text = model.created
        cell.textBodyLabel.text = model.content
        
        cell.layoutIfNeeded()
        
        
        cell.messageWrapperView.layer.cornerRadius = 8
        
        cell.messageWrapperView.layer.zPosition = CGFloat.greatestFiniteMagnitude
        return cell
        
    }
    
    
}
