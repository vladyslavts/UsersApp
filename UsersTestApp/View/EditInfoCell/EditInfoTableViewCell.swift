//
//  EditInfoTableViewCell.swift
//  UsersTestApp
//
//  Created by Andrii Mazepa on 10/5/18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

protocol EditInfoTableViewCellDelegate {
    
    func cell(_ cell: EditInfoTableViewCell, didUpdateInfo info: String)
}

class EditInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var infoField: UITextField!
    var delegate: EditInfoTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        infoField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func identifier() -> String {
        return "EditInfoTableViewCell"
    }
}

extension EditInfoTableViewCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.delegate?.cell(self, didUpdateInfo: textField.text!)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
