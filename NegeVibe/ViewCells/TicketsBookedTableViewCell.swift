//
//  TicketsBookedTableViewCell.swift
//  NegeVibe
//
//  Created by Dor tzemach on 09/01/2019.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class TicketsBookedTableViewCell: UITableViewCell {
    @IBOutlet weak var icBarcodeUIImageView: UIImageView!
    @IBOutlet weak var monthUILabel: UILabel!
    @IBOutlet weak var dayUILabel: UILabel!
    @IBOutlet weak var eventTitleUILabel: UILabel!
    @IBOutlet weak var locationEventUILabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
