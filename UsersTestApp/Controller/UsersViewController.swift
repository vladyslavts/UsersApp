//
//  UsersViewController.swift
//  UsersTestApp
//
//  Created by Andrii Mazepa on 10/4/18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

private let editUserSegueIdentifier = "EditUserInfoViewController"
private let usersLoadCount = 20

class UsersViewController: UIViewController {
    var users = [User]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func loadView() {
        super.loadView()
        tableView.register(UINib(nibName: UserTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: UserTableViewCell.identifier())

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUsers()
        
        // Do any additional setup after loading the view.
    }
    
   
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let indexPath = tableView.indexPathForSelectedRow

        if segue.identifier == editUserSegueIdentifier {
            let vc = segue.destination as! EditUserInfoViewController
            vc.selectedUser = self.users[indexPath!.row].copy() as! User
            vc.hidesBottomBarWhenPushed = true
            let backItem = UIBarButtonItem()
            backItem.title = ""
            self.navigationItem.backBarButtonItem = backItem
        }
    }
    
    // MARK: Private func
    
    private func loadUsers() {
        ServerManager.shared.loadUsers(count: usersLoadCount) { (users, error) in
            self.users.append(contentsOf: users)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

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
        cell.userPic.loadFrom(URL(string: user.photoURL)!)
        return cell
    }
}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: editUserSegueIdentifier, sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == users.count - 1 {
            loadUsers()
            let index = IndexPath(row: users.count-1, section: 0)
          //  tableView.scrollToRow(at: index, at: UITableView.ScrollPosition.bottom, animated: true)
        }
    }
}
