//
//  EventMenuViewController.swift
//  NegeVibe
//
//  Created by Ran Loock on 27/12/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit



class EventMenuViewController: UIViewController {

 
    @IBOutlet weak var menuTable: UITableView!
    var menu:[EventMenuItem] = EventMenu.shared().getMenu()
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTable.rowHeight = menuTable.frame.height / 5.0
        // Do any additional setup after loading the view.
        if let navBar = self.navigationController{
            self.navigationItem.title = "תפריט אירועים"
            navBar.view.tintColor = UIColor.white
        }
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
        return cell
    }
    
    
}
