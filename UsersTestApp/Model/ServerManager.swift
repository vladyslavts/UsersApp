//
//  ServerManager.swift
//  UsersTestApp
//
//  Created by Andrii Mazepa on 10/4/18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

struct Users: Codable {
    let results: [Result]
}

struct Result: Codable {
    let name: Name
    let email: String
    let phone, cell: String
    let picture: Picture
}

struct Name: Codable {
    let first, last: String
}

struct Picture: Codable {
    let large, medium, thumbnail: URL
}

private let baseURL = "https://randomuser.me/api/?"

class ServerManager: NSObject {
    
    public static let shared = ServerManager()
    
    func loadUsers(count: Int, completionHandler: @escaping(_ users: [User], _ error: Error?) -> Void)  {
        let urlString = baseURL + "results=\(count)"
        var usersArray = [User]()
       
        guard let URL = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: URL) { (data, response, error) in
            guard let data = data else {return}
            guard error == nil else {return}
            do {
                let users = try JSONDecoder().decode(Users.self, from: data)
                for result in users.results {
                    let user = User(withResponse: result)
                    usersArray.append(user)
                }
                completionHandler(usersArray, nil)
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
