//
//  ChatViewController.swift
//  NegeVibe
//
//  Created by Ran Loock on 18/01/2019.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    let mockupChat = [ChatMessage]()
    @IBOutlet weak var textWrapperView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

    
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textWrapperView.layer.cornerRadius = textWrapperView.bounds.height / 2
    }
    
    

}
extension ChatViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockupChat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "otherChat") as! OtherChatMessageTableViewCell
        return cell
    }
    
    
}
