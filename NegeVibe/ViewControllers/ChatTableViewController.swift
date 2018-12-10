//
//  ChatTableViewController.swift
//  NegeVibe
//
//  Created by Ofir Elias on 08/12/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class ChatTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    
    @IBOutlet var messageTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var heightConstrain: NSLayoutConstraint!
    
    
    
    var messageArray:[Message] = [Message]()
    let user = "Ofir"
    
    var m2:Message = Message()
    
    var m1:Message = Message()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //disable IQKeyboard
        IQKeyboardManager.shared.enable = false
        //message push
        m1.sender = user
        m1.messageBody = "How are you guys good to be here!"
        
        
        m2.sender = "theDude"
        m2.messageBody = "how are you men log time no seen!"
        messageArray.append(m2)
        
        
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTaped))
        messageTableView.addGestureRecognizer(tapGesture)
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        
        
        
//        messageTableView.register(UINib(nibName: "", bundle: nil), forCellReuseIdentifier: "")//customMessageCell
        messageTableView.separatorStyle = .none
        cunfigurTableView()
    }

    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
*/
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
            return messageArray.count//messageArray.count
            
    }





        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageViewCell
        

        // Configure the cell...
            
            // TODO:Chanege sendeer check to data base verefcation
            if messageArray[indexPath.row].sender != user {
                cell.messageBackground.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                cell.senderUserName.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cell.senderBody.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            cell.senderUserName.text! = messageArray[indexPath.row].sender
            cell.senderBody.text! = messageArray[indexPath.row].messageBody
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    //message text container size change
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2) {
            self.heightConstrain.constant = 390
            self.view.layoutIfNeeded()
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.2) {
        self.heightConstrain.constant = 70
        self.view.layoutIfNeeded()
        }
    }
    
    @objc func tableViewTaped(){
        messageTextField.endEditing(true)
    }
    
    
    
    @IBAction func sendButtenPressed(_ sender: Any) {
        messageTextField.endEditing(true)
        
        //TODO: Add data from text filed to the server!
        
        
        let m3:Message = Message.init()
        m3.messageBody = messageTextField.text!
        m3.sender = user
        messageArray.append(m3)
        
        messageTextField.text = ""
        
        
        
        
        cunfigurTableView()
        self.messageTableView.reloadData()
        print(messageArray.count)
        
        
    }
    
    
    //message baloon row height configuration
    func cunfigurTableView() {
        messageTableView.rowHeight = UITableView.automaticDimension
        messageTableView.estimatedRowHeight = 120.0
        
    }

}
