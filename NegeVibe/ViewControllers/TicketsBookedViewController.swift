//
//  TicketsBookedViewController.swift
//  NegeVibe
//
//  Created by Dor tzemach on 09/01/2019.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class TicketsBookedViewController: UIViewController {

    @IBOutlet weak var ticketsBookedTable: UITableView!
    var arrEvent = [Event]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.title = "כרטיסים שהוזמנו"

        // Do any additional setup after loading the view.
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

extension TicketsBookedViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrEvent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "ticketsBookedCell", for: indexPath) as! TicketsBookedTableViewCell
        
        let ticketsBooked = arrEvent[indexPath.item]
        cell.eventTitleUILabel.text = ticketsBooked.title
        cell.locationEventUILabel.text = ticketsBooked.locationname
        let dateInput = ticketsBooked.date
        let formater2 = DateFormatter()
        formater2.locale = Locale(identifier: "en_US_POSIX")
        formater2.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let day = formater2.date(from: dateInput){
            formater2.locale = Locale(identifier: "he_IL")
            formater2.dateFormat = "d"
            let formattedStr = formater2.string(from: day)
            cell.dayUILabel.text = formattedStr
        }
        let formater = DateFormatter()
        formater.locale = Locale(identifier: "en_US_POSIX")
        formater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let month  = formater.date(from: dateInput){
            formater.locale = Locale(identifier: "he_IL")
            formater.dateFormat = "MMMM"
            let formattedDate = formater.string(from: month)
            cell.monthUILabel.text = formattedDate
        }
        
        return cell

        
        
    }
    }
    
   

