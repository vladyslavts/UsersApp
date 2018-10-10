//
//  User.swift
//  UsersTestApp
//
//  Created by Andrii Mazepa on 10/4/18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

class User: NSObject, NSCopying {
  
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String
    var photoURL: String
    
    var fullName: String {
        get {
            return (self.firstName + " " + self.lastName).capitalized
        }
    }
    
    init(withResponse response: Result) {
        self.firstName = response.name.first.capitalized
        self.lastName = response.name.last.capitalized
        self.email = response.email
        self.phoneNumber = response.phone
        self.photoURL = response.picture.medium
    }
    
    override init() {
        self.firstName = ""
        self.lastName = ""
        self.email = ""
        self.phoneNumber = ""
        self.photoURL = ""
    }
    
  
    func copy(with zone: NSZone? = nil) -> Any {
        let user = User()
        user.firstName = self.firstName
        user.lastName = self.lastName
        user.email = self.email
        user.phoneNumber = self.phoneNumber
        user.photoURL = self.photoURL
        return user
    }
}
