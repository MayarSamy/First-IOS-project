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
    
    var isLoggedIn:Bool  {
        set {
            UserDefaults.standard.set(newValue, forKey: "isLoggedIn" )
        }
        get {
            guard UserDefaults.standard.object(forKey: "isLoggedIn" ) != nil else {
                return false
            }
            return UserDefaults.standard.bool(forKey: "isLoggedIn" )
        }
    }
    
    var user : User {
        set {
            setUserDefaults(newValue)
        }
        get {
            return getUserDefaults()!
        }
    }
    
    //set user default
    private func setUserDefaults(_ user: User) {
        let encoder = JSONEncoder()
        if let encodded = try? encoder.encode(user) {
            UserDefaults.standard.set(encodded, forKey: "user")
        }
    }
    
    //get user defaults
    private func getUserDefaults() -> User? {
        if let savedUser =  UserDefaults.standard.object(forKey: "user") as? Data {
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(User.self, from: savedUser) {
                return loadedUser
            }
        }
        return nil
    }
 }

