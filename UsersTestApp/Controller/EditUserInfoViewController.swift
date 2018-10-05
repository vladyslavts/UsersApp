//
//  ViewController.swift
//  UsersTestApp
//
//  Created by Andrii Mazepa on 10/4/18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

class EditUserInfoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userPic: UIImageView!
    
    override func loadView() {
        super.loadView()
        tableView.register(UINib(nibName: EditInfoTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: EditInfoTableViewCell.identifier())

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func changePhoto(_ sender: UIButton) {
    }
    
}

extension EditUserInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EditInfoTableViewCell.identifier(), for: indexPath) as! EditInfoTableViewCell
        return cell
    }
    
    
}

extension EditUserInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
