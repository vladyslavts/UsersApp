//
//  ViewController.swift
//  UsersTestApp
//
//  Created by Andrii Mazepa on 10/4/18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

enum RowType: Int {
    case FirstName = 0
    case LastName
    case Email
    case PhoneNumber
}

class EditUserInfoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userPic: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var selectedUser = User()

    override func loadView() {
        super.loadView()
        tableView.register(UINib(nibName: EditInfoTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: EditInfoTableViewCell.identifier())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
    
    @IBAction func changePhoto(_ sender: UIButton) {
    }
    
   
    @objc func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo!
        let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let viewFrame = view.convert(endFrame, from: view.window)
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: viewFrame.height + 20, right: 0)
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.scrollView.contentInset = contentInset
    }
    
    // MARK: - Observers
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
}

extension EditUserInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EditInfoTableViewCell.identifier(), for: indexPath) as! EditInfoTableViewCell
   
     
        let type: RowType  =  RowType(rawValue: indexPath.row)!
        
        switch type {
        case .FirstName:
            cell.label.text = "FirstName"
        case .LastName:
            cell.label.text = "LastName"

        case .Email:
            cell.label.text = "Email"

        case .PhoneNumber:
            cell.label.text = "PhoneNumber"

        }
        

        return cell
    }
}

extension EditUserInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
