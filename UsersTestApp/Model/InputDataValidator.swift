//
//  InputDataValidator.swift
//  UsersTestApp
//
//  Created by Andrii Mazepa on 10/10/18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

private let namePattern = "[a-zA-Z]{1,30}"
private let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

class InputDataValidator: NSObject {

    func isValidName(name: String) -> Bool {
        let test = NSPredicate(format:"SELF MATCHES %@", namePattern)
        return test.evaluate(with: name)
    }
    
    func isValidEmail(email: String) -> Bool {        
        let test = NSPredicate(format:"SELF MATCHES %@", emailPattern)
        return test.evaluate(with: email)
    }
    
}
