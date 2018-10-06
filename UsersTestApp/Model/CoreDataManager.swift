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
        savedUser.email = user.email
        savedUser.phoneNumber = user.phoneNumber
        //savedUser.userPic
        saveContext()
       // removeAll()
        completionHandler()
    }

    func load() {
        let users  = try! context.fetch(SavedUser.fetchRequest()) as! [SavedUser]
        for user in users {
            print(user.firstName!)
        }
       // print(users)

    }

    //MARK: - Private func

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }

   private func removeAll() {
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
