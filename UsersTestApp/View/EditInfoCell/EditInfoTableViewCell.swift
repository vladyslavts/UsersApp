//
//  EditInfoTableViewCell.swift
//  UsersTestApp
//
//  Created by Andrii Mazepa on 10/5/18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

class EditInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var infoField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func identifier() -> String {
        return "EditInfoTableViewCell"
    }
}
