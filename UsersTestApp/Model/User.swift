//
//  User.swift
//  UsersTestApp
//
//  Created by Andrii Mazepa on 10/4/18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

class User: NSObject {
    
    let firstName: String
    let lastName: String
    let email: String
    let phoneNumber: String
    let photoURL: URL
    
    var fullName: String {
        get {
            return (self.firstName + " " + self.lastName).capitalized
        }
    }
    
    init(withResponse response: Result) {
        self.firstName = response.name.first
        self.lastName = response.name.last
        self.email = response.email
        self.phoneNumber = response.phone
        self.photoURL = response.picture.medium
    }
    
    override init() {
        self.firstName = ""
        self.lastName = ""
        self.email = ""
        self.phoneNumber = ""
        self.photoURL = URL(string: "")!
    }
}
