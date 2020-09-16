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
    //var image : CodableImage!
    var name : String!
    var email : String!
    var phone : String!
    var address : String!
    var password : String!
    var gender : Gender!
}

struct CodableImage : Codable {
    let imageData : Data?
    
    init(withImage image: UIImage) {
        self.imageData = image.jpegData(compressionQuality: 1.0)
    }
    
    func getImage() -> UIImage? {
        guard let imageData = self.imageData else {
            return nil
        }
        let image = UIImage(data: imageData)
        return image
    }
}
