//
//  Media.swift
//  first ios project
//
//  Created by IOS on 9/6/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation

enum MediaType : String {
    case movie
    case music
    case tvShow
}

struct Media : Decodable {
    var artworkUrl100 : String
    var artistName : String?
    var trackName : String?
    var longDescription : String?
    var previewUrl : String
    var kind : String?
    
    func getType() -> MediaType {
        switch self.kind {
        case "song":
            return MediaType.music
        case "tv-episode":
            return MediaType.tvShow
        case "feature-movie":
            return MediaType.movie
        default:
            return MediaType.music
        }
    }
}


