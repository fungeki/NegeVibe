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
        if indexPath.row == 3{
            cell.descriptionLabel.textColor = getBrightOrange()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
        let ticketVC = self.storyboard?.instantiateViewController(withIdentifier: "ticketVC") as! TicketViewController
        self.navigationController?.pushViewController(ticketVC, animated: true)
        case 3:
            let addEventVC = self.storyboard?.instantiateViewController(withIdentifier: "addEventVC") as! MyEventViewController
            self.navigationController?.pushViewController(addEventVC, animated: true)
        default:
            return
        }
        
    }
    
}
