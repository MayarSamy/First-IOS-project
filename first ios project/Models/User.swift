//
//  User.swift
//  first ios project
//
//  Created by IOS on 8/5/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit

enum Gender : String, Codable{
    case female
    case male
}

struct User : Codable {
    var image : Data!
    var name : String!
    var email : String!
    var phone : String!
    var address : String!
    var password : String!
    var gender : Gender!
}

struct CodableImage : Codable {
    let imageData : Data?
    
    static func setImage(image: UIImage) -> Data? {
        let data = image.jpegData(compressionQuality: 1.0)
        return data
    }
    
    static func getImage(imageData: Data?) -> UIImage? {
        guard let imageData = imageData else {
            return nil
        }
        let image = UIImage(data: imageData)
        return image
    }
}
