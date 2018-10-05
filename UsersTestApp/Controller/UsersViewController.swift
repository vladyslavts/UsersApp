//
//  UsersViewController.swift
//  UsersTestApp
//
//  Created by Andrii Mazepa on 10/4/18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    var users = [User]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func loadView() {
        super.loadView()
        tableView.register(UINib(nibName: UserTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: UserTableViewCell.identifier())

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        ServerManager.shared.loadUsers(count: 250) { (users, error) in
            self.users = users;
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        // Do any additional setup after loading the view.
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

extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier(), for: indexPath) as! UserTableViewCell

        let user: User = self.users[indexPath.row]
        cell.userPhoneNumber.text = user.phoneNumber
        cell.userFullName.text = user.fullName
        return cell
    }
    
}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
