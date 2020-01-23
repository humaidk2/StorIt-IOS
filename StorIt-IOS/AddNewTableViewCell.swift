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
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 150))
        return view
    }()
    
    //image for folder
    lazy var folderImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 30, y: 10, width: 40, height: 40))
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.cornerRadius = imageView.bounds.width/2
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
     //image for secure upload
    lazy var secureUploadImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 180, y: 10, width: 40, height: 40))
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.cornerRadius = imageView.bounds.width/2
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
     //image for upload
    lazy var uploadImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: self.frame.width - 5, y: 10, width: 40, height: 40))
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.cornerRadius = imageView.bounds.width/2
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    //60 because u have to start from 0
    //on top x is 15 plus width 30 so total is 45
    //to put some space for title add 15 = 60
    lazy var folder: UILabel = {
        let title = UILabel(frame: CGRect(x: 30, y: 60, width: 80, height: 30))
        return title
    }()
    
    lazy var secureUpload: UILabel = {
        let title = UILabel(frame: CGRect(x: 155, y: 60, width: 150, height: 30))
        return title
    }()
    
    lazy var upload: UILabel! = {
        let title = UILabel(frame: CGRect(x: self.frame.width - 5, y: 60, width: 80, height: 30))
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
        backView.addSubview(folderImage)
        backView.addSubview(secureUploadImage)
        backView.addSubview(uploadImage)
        // Configure the view for the selected state
    }

  
}
