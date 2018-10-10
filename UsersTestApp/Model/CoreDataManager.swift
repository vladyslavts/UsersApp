//
//  CoreDataManager.swift
//  UsersTestApp
//
//  Created by Vladyslav on 10/6/18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
import CoreData

private let appDelegate = UIApplication.shared.delegate as! AppDelegate
private let context = appDelegate.persistentContainer.viewContext

class CoreDataManager: NSObject {

    public static let shared = CoreDataManager()

    private override init() {
        super.init()
    }

    func save(_ user: User, completionHandler: @escaping () -> Void ) {
        let savedUser = SavedUser(context: context)
        savedUser.firstName = user.firstName
        savedUser.lastName = user.lastName
        savedUser.fullName = user.fullName
        savedUser.email = user.email
        savedUser.phoneNumber = user.phoneNumber
        savedUser.userPic = user.photoURL
        saveContext()
        completionHandler()
    }

    func loadUsers(complitionHandler: @escaping(_ users: [User]) -> Void) {
        let users  = try! context.fetch(SavedUser.fetchRequest()) as! [SavedUser]
        var userModels = [User]()
        for savedUser in users {
            let user: User = User(withSavedModel: savedUser)
            userModels.append(user)
        }
        complitionHandler(userModels)
    }

    //MARK: - Private func

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }

    func removeAll() {
        do {
            let objects = try context.fetch(SavedUser.fetchRequest()) as! [SavedUser]
            for object in objects {
                context.delete(object)
            }
            saveContext()
        } catch {
            
    }
    }

}
