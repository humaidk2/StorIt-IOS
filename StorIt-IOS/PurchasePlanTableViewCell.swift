//
//  PurchasePlanTableViewCell.swift
//  StorIt-IOS
//
//  Created by Fidel Lim on 2/20/20.
//  Copyright © 2020 Cyber-Monkeys. All rights reserved.
//

import UIKit

class PurchasePlanTableViewCell: UITableViewCell {

    //variables
    @IBOutlet weak var radioButtonImage: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //when radio button is pressed
    @IBAction func pressedRadioButton(_ sender: UIButton) {
        
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    
}
