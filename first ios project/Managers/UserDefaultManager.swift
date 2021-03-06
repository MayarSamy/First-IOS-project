//
//  UserDefaultManager.swift
//  first ios project
//
//  Created by IOS on 8/14/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation
import UIKit

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
    
    var mediaType: MediaType {
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "MediaType")
        }
        get {
            guard UserDefaults.standard.object(forKey: "MediaType") != nil else {
                return MediaType.movie
            }
            return UserDefaults.standard.string(forKey: "MediaType").map { MediaType(rawValue: $0)! }!
        }
    }
    
//        var user : User {
//            set {
//                setUserDefaults(newValue)
//            }
//            get {
//                return getUserDefaults(ne)
//            }
//        }
    
//    set user default
//         func setImage(_ user: UIImage) -> Data{
//            let encoder = JSONEncoder()
//            var encocdedUser : Data = Data()
//            if let encodded = try? encoder.encode(user){
//                encocdedUser = encodded
//            }
//            return encocdedUser
//        }
//    
////    get user defaults
//     func getImage(_ user: Data) -> User? {
//                let decoder = JSONDecoder()
//                if let loadedUser = try? decoder.decode(User.self, from: user) {
//                    return loadedUser
//                }
//            return nil
//        }
 }

