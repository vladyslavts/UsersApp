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
        infoField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    class func identifier() -> String {
        return "EditInfoTableViewCell"
    }
}

extension EditInfoTableViewCell: UITextFieldDelegate {
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.delegate?.cell(self, didUpdateInfo: textField.text ?? "")
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
