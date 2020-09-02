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
    static func loadMovies( completion: @escaping (_ error: Error?, _ movies: [Movies]?) -> Void) {
        let url = "https://api.androidhive.info/json/movies.json"
        Alamofire.request(url, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: nil).response {
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
                let moviesArray = try decoder.decode([Movies].self, from: data)
                completion(nil, moviesArray)
            }
            catch let error {
                print(error)
            }
        }
    }
}