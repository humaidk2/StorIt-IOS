//
//  PaymentDetailsTableViewCell.swift
//  StorIt-IOS
//
//  Created by Fidel Lim on 2/20/20.
//  Copyright © 2020 Cyber-Monkeys. All rights reserved.
//

import UIKit

class PaymentDetailsTableViewCell: UITableViewCell {

    //variables
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
