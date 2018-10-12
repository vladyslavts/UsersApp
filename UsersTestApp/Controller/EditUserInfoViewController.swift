//
//  ViewController.swift
//  UsersTestApp
//
//  Created by Andrii Mazepa on 10/4/18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

enum CellType: Int {
    case FirstName = 0
    case LastName
    case Email
    case PhoneNumber
}

class EditUserInfoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userPic: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var selectedUser = User()
    let validator = InputDataValidator()
    
    override func loadView() {
        super.loadView()
        tableView.register(UINib(nibName: EditInfoTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: EditInfoTableViewCell.identifier())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userPic.layer.cornerRadius = userPic.frame.width / 2
        userPic.loadFrom(URL(string: selectedUser.photoURL)!)
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
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        CoreDataManager.shared.save(selectedUser) {
            self.tabBarController?.selectedIndex = 1
            self.navigationController?.popToRootViewController(animated: true)
        }
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
    private func configure(_ cell: EditInfoTableViewCell, forRowAt indexPath: IndexPath) -> EditInfoTableViewCell {
        let type: CellType  =  CellType(rawValue: indexPath.row)!
        
        switch type {
        case .FirstName:
            cell.label.text = "First name"
            cell.infoField.text = selectedUser.firstName
            cell.infoField.keyboardType = .namePhonePad

        case .LastName:
            cell.label.text = "Last name"
            cell.infoField.text = selectedUser.lastName
            cell.infoField.keyboardType = .namePhonePad

        case .Email:
            cell.label.text = "Email"
            cell.infoField.text = selectedUser.email
            cell.infoField.keyboardType = .emailAddress

        case .PhoneNumber:
            cell.label.text = "Phone number"
            cell.infoField.text = selectedUser.phoneNumber
            cell.infoField.keyboardType = .phonePad
        default:
            break
        }
        
        cell.tag = type.rawValue
        return cell
    }
    
    func updateUser(with info: String, and infoType: CellType)  {
        switch infoType {
        case .FirstName:
            if validator.isValidName(name: info) {
                selectedUser.firstName = info
            }
            saveButton.isEnabled = validator.isValidName(name: info)
       
        case .LastName:
            if validator.isValidName(name: info) {
                selectedUser.lastName = info
            }
            saveButton.isEnabled = validator.isValidName(name: info)

        case .Email:
            if validator.isValidEmail(email: info) {
                selectedUser.email = info
            }
            saveButton.isEnabled = validator.isValidEmail(email: info)

        case .PhoneNumber:
            selectedUser.phoneNumber = info
        default:
            break
        }
    }
}

extension EditUserInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EditInfoTableViewCell.identifier(), for: indexPath) as! EditInfoTableViewCell
        cell.delegate = self
        return configure(cell, forRowAt: indexPath)
    }
    
    
}

extension EditUserInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension EditUserInfoViewController: EditInfoTableViewCellDelegate {
    func cell(_ cell: EditInfoTableViewCell, didUpdateInfo info: String) {
        updateUser(with: info, and: CellType(rawValue: cell.tag)!)
    }
}
