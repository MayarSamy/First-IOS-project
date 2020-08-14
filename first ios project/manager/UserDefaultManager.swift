//
//  UserDefaultManager.swift
//  first ios project
//
//  Created by IOS on 8/14/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation

class UserDefaultManager {
    private init() {}
    
    private static let sharedInstance = UserDefaultManager()
    static func shared() -> UserDefaultManager {
        return UserDefaultManager.sharedInstance
    }
}
