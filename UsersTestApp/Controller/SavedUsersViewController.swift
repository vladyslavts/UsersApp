//
//  SavedUsersViewController.swift
//  UsersTestApp
//
//  Created by Andrii Mazepa on 10/9/18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

class SavedUsersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var savedUsers = [SavedUser]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: UserTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: UserTableViewCell.identifier())
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadUsers()
    }
    private func loadUsers() {
        CoreDataManager.shared.loadUsers { (users) in
            self.savedUsers = users
            self.tableView.reloadData()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SavedUsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier(), for: indexPath) as! UserTableViewCell
        
        let savedUser: SavedUser = savedUsers[indexPath.row]
        cell.userPhoneNumber.text = savedUser.phoneNumber
        cell.userFullName.text = savedUser.fullName
        cell.userPic.loadFrom(URL(string: savedUser.userPic!)!)
        return cell
    }
    
    
}

extension SavedUsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "azaza", sender: nil)
    }
}
