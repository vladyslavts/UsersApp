//
//  File.swift
//  UsersTestApp
//
//  Created by Andrii Mazepa on 10/5/18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadFrom(_ url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
