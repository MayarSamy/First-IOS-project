//
//  APIManager.swift
//  first ios project
//
//  Created by IOS on 9/2/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    static func loadMedia(mediaType: String, criteria: String, completion: @escaping (_ error: Error?, _ media: [Media]?) -> Void) {
            
            let param = [Params.media: mediaType, Params.term: criteria]
        
            Alamofire.request(Urls.media, method: HTTPMethod.get, parameters: param, encoding: URLEncoding.default, headers: nil).response {
                response in
    
                guard response.error == nil else {
                    completion(response.error, nil)
                    return
                }
    
                guard let data = response.data else {
                    print("no data found")
                    return
                }
    
                do {
                    let decoder = JSONDecoder()
                    let mediaArray = try decoder.decode(MediaResponse.self, from: data).results
                    completion(nil, mediaArray)
                }
                catch let error {
                    print(error)
                }
            }
        }
}
