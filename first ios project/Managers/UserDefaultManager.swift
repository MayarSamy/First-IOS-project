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
    
    
    var email:String  {
        set {
            UserDefaults.standard.set(newValue, forKey: "email" )
        }
        get {
            guard UserDefaults.standard.object(forKey: "email" ) != nil else {
                return ""
            }
            return UserDefaults.standard.string(forKey: "email")!
        }
    }
 }

