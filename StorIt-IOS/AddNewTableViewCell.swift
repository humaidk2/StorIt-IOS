//
//  AddNewTableViewCell.swift
//  StorIt-IOS
//
//  Created by Fidel Lim on 1/17/20.
//  Copyright © 2020 Cyber-Monkeys. All rights reserved.
//

import UIKit

class AddNewTableViewCell: UITableViewCell {
    
    //height of cell is 50
    //that is why height is 50
    lazy var backView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 50))
        return view
    }()
    
//    lazy var settingImage: UIImageView = {
//        let imageView = UIImageView(frame: CGRect(x: 15, y: 10, width: 30, height: 30))
//        return imageView
//    }()
    
    //60 because u have to start from 0
    //on top x is 15 plus width 30 so total is 45
    //to put some space for title add 15 = 60
    lazy var folder: UILabel = {
        let title = UILabel(frame: CGRect(x: 15, y: 10, width: 80, height: 30))
        return title
    }()
    
    lazy var secureUpload: UILabel = {
        let title = UILabel(frame: CGRect(x: 105, y: 10, width: 150, height: 30))
        return title
    }()
    
    lazy var upload: UILabel! = {
        let title = UILabel(frame: CGRect(x: 265, y: 10, width: 80, height: 30))
        return title
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(backView)
        
        backView.addSubview(folder)
        backView.addSubview(secureUpload)
        backView.addSubview(upload)
        // Configure the view for the selected state
    }

  
}
