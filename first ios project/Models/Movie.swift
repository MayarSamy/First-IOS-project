//
//  Movie.swift
//  first ios project
//
//  Created by IOS on 8/26/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation

struct Movies: Decodable {
    
    var image : String
    var title : String
    var genre : String
    var releaseYear : Int
    var rating : Double
}
