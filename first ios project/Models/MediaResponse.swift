//
//  MediaResponse.swift
//  first ios project
//
//  Created by IOS on 9/6/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation

struct MediaResponse : Decodable {
    var resultCount : Int
    var results : [Media]
}
