//
//  EventMenuViewController.swift
//  NegeVibe
//
//  Created by Ran Loock on 27/12/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit
import Firebase



class EventMenuViewController: UIViewController {

    weak var actionToEnable : UIAlertAction?
    weak var db: Firestore?

    @IBOutlet weak var menuTable: UITableView!
    var menu:[EventMenuItem] = EventMenu.shared().getMenu()
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        menuTable.rowHeight = menuTable.bounds.height / 4.5
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func showAlert()
    {
        let titleStr = "שם משתמש/ת"
        let messageStr = "אנא בחר/י שם משתמש/ת בכדי להמשיך"
        
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert)
        
        let placeholderStr =  "לפחות 4 אותיות או מספרים"
        
        alert.addTextField(configurationHandler: {(textField: UITextField) in
            textField.placeholder = placeholderStr
            textField.textAlignment = .right
            textField.font = UIFont(name: "VarelaRound-Regular", size: 14)
            textField.addTarget(self, action: #selector(self.textChanged(_:)), for: .editingChanged)
        })
        
        let cancel = UIAlertAction(title: "ביטול", style: UIAlertAction.Style.cancel, handler: { (_) -> Void in
            
        })
        
        let action = UIAlertAction(title: "אישור", style: UIAlertAction.Style.default, handler: { (_) -> Void in
            let textfield = alert.textFields!.first!
            guard let userName = textfield.text else {
                print("error retrieving username")
                return
            }
            
            updateUsername(userName)
            //Do what you want with the textfield!
        })
        
        alert.addAction(cancel)
        alert.addAction(action)
        
        self.actionToEnable = action
        action.isEnabled = false
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func textChanged(_ sender:UITextField) {
        var isLegal = true
        let text = sender.text!
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 פםןוטארקףךלחיעכגדשץתצמנהבסז")
        if text.rangeOfCharacter(from: characterset.inverted) != nil {
            isLegal = false
        }
        self.actionToEnable?.isEnabled  = (text.count > 3 && isLegal)
    }
}
extension EventMenuViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell") as! EventMenuTableViewCell
        cell.selectionStyle = .none
        let model = menu[indexPath.row]
        cell.iconImage.image = model.icon
        cell.descriptionLabel.text = model.text
        cell.layoutSubviews()
        if indexPath.row == 3 || indexPath.row == 2{
            cell.descriptionLabel.textColor = getBrightOrange()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
        let TicketsBookedVC = self.storyboard?.instantiateViewController(withIdentifier: "TicketsBookedVC") as! TicketsBookedViewController
        self.navigationController?.pushViewController(TicketsBookedVC, animated: true)
        case 2:
            
//            getUserChatName(completion: { (str) in
//                let ChatListVC =
//                    self.storyboard?.instantiateViewController(withIdentifier: "ChatListVC") as! ChatListViewController
//                self.navigationController?.pushViewController(ChatListVC, animated: true)
//            })
            if SignedInUser.getInstance().getChatName() == nil{
                showAlert()
            } else {
                let ChatListVC =
                    self.storyboard?.instantiateViewController(withIdentifier: "ChatListVC") as! ChatListViewController
                self.navigationController?.pushViewController(ChatListVC, animated: true)
            }
            
            
        case 3:
            let addEventVC = self.storyboard?.instantiateViewController(withIdentifier: "addEventVC") as! MyEventViewController
            self.navigationController?.pushViewController(addEventVC, animated: true)
        default:
            return
        }
        
    }
    
}
