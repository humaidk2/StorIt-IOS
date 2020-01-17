//
//  SortByTableViewCell.swift
//  StorIt-IOS
//
//  Created by Fidel Lim on 1/17/20.
//  Copyright © 2020 Cyber-Monkeys. All rights reserved.
//

import UIKit

class SortByTableViewCell: UITableViewCell {

    //height of cell is 50
    //that is why height is 50
    lazy var backView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 50))
        return view
    }()
    
    lazy var settingImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 15, y: 10, width: 30, height: 30))
        return imageView
    }()
    
    //60 because u have to start from 0
    //on top x is 15 plus width 30 so total is 45
    //to put some space for title add 15 = 60
    lazy var title: UILabel = {
        let title = UILabel(frame: CGRect(x: 60, y: 10, width: self.frame.width - 80, height: 30))
        return title
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(backView)
        backView.addSubview(settingImage)
        backView.addSubview(title)
        // Configure the view for the selected state
    }

}

