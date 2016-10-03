//
//  RestaurantStore.swift
//  TheForkTest
//
//  Created by SIFFRE on 01/10/2016.
//  Copyright © 2016 Siffrej. All rights reserved.
//

import Foundation
import CoreData

class RestaurantStore {
    
    //let coreDataStack = CoreDataStack(modelName: "Restaurant")
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    private func parseRestaurant(withID idRestaurant: Int, fromData data: Data?, error: Error?) -> RestaurantResult {
        guard data != nil else {
            
            return .Failure(error!)
        }
        
        return TheForkApi.restaurant(fromData: data!)
    }
    
    func fetchRecentRestaurant(withID idRestaurant: Int, completion: @escaping (RestaurantResult) -> Void) {
        
        let url: URL = TheForkApi.infoRestaurantUrl(forRestaurantId: idRestaurant)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            // parse here (using TheForkAPi)
            let result = self.parseRestaurant(withID: idRestaurant, fromData: data, error: error)
            
            completion(result)
        }
        task.resume()
    }


}
