//
//  UserMessageTextCell.swift
//  design04
//
//  Created by IT-ELEVEN on 28/9/15.
//  Copyright © 2015 swiftcombat. All rights reserved.
//

import UIKit

class UserMessageTextCell: UITableViewCell {

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        
        let userPictureView = UIView(frame: CGRectMake(0, 0, 75, 65))
        userPictureView.backgroundColor = UIColor.redColor()
        self.addSubview(userPictureView)
        
        let disclouseImage = UIImageView(frame: CGRectMake(0, 0, 9, 15))
        disclouseImage.image = UIImage(named: "disclouse_icon")
        disclouseImage.tintColor = UIColor.redColor()
        
        self.accessoryView = disclouseImage
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
