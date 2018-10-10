//
//  SavedUsersViewController.swift
//  UsersTestApp
//
//  Created by Andrii Mazepa on 10/9/18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

private let detailInfoIdentifier = "showDetailInfo"

class SavedUsersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var savedUsers = [User]()

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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let indexPath = tableView.indexPathForSelectedRow
        
        if segue.identifier == detailInfoIdentifier {
            let vc = segue.destination as! EditUserInfoViewController
            vc.selectedUser = self.savedUsers[indexPath!.row]
            vc.hidesBottomBarWhenPushed = true
            let backItem = UIBarButtonItem()
            backItem.title = ""
            self.navigationItem.backBarButtonItem = backItem
        }
    }
 

}

extension SavedUsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier(), for: indexPath) as! UserTableViewCell
        
        let savedUser: User = savedUsers[indexPath.row]
        cell.userPhoneNumber.text = savedUser.phoneNumber
        cell.userFullName.text = savedUser.fullName
        cell.userPic.loadFrom(URL(string: savedUser.photoURL)!)
        return cell
    }
    
    
}

extension SavedUsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: detailInfoIdentifier, sender: nil)
    }
}
