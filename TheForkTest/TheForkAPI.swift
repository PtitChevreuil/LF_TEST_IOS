//
//  TheForkAPI.swift
//  TheForkTest
//
//  Created by SIFFRE on 01/10/2016.
//  Copyright © 2016 Siffrej. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreData

enum Method: String {
    case InfoRestaurant = "restaurant_get_info"
}

enum RestaurantResult {
    case Success(RestaurantModel)
    case Failure(Error)
}

enum RestaurantError: Error {
    case ParsingError
}

struct TheForkApi {
    
    private static let baseURLString = "https://api.lafourchette.com/api"
    private static let APIKey = "IPHONEPRODEDCRFV"
    
    private static func theForkUrl(method: Method,
                                 parameters: [String:String]?) -> URL {
        let components = NSURLComponents(string: baseURLString)!
        
        var queryParams = [NSURLQueryItem]()
        
        let baseParams = [
            "key": APIKey,
            "method": method.rawValue
        ]
        
        for (key, value) in baseParams {
            let item = NSURLQueryItem(name: key, value: value)
            queryParams.append(item)
        }
        
        if let additionalParams = parameters {
            for (key, value) in additionalParams {
                let item = NSURLQueryItem(name: key, value: value)
                queryParams.append(item)
            }
        }
        components.queryItems = queryParams as [URLQueryItem]?
        
        return components.url!
    }
    
    static func infoRestaurantUrl(forRestaurantId idRestaurant: Int) -> URL {
        return theForkUrl(method: .InfoRestaurant,
                         parameters: ["id_restaurant": String(idRestaurant)])
    }
    
    static func restaurant(fromData data: Data) -> RestaurantResult {
                
        var json = JSON(data: data)
        
        if json["result"].intValue == 1 {
            
            let name = json["data"]["name"]
            let id = json["data"]["id_restaurant"]
            let url = json["data"]["portal_url"]
            
            
            // let say this is the minimum amout of data needed to create a restaurant
            guard name != nil && id != nil && url != nil else {
                return .Failure(RestaurantError.ParsingError)
            }
            
            let gps_lat = json["data"]["gps_lat"].doubleValue
            let gps_long = json["data"]["gps_long"].doubleValue
            let address = json["data"]["address"].stringValue
            let city = json["data"]["city"].stringValue
            let zipcode = json["data"]["zipcode"].stringValue
            let rate_cout = json["data"]["rate_count"].stringValue
            let card_price = json["data"]["card_price"]
            let pics: String = json["data"]["pics_main"]["612x344"].stringValue
            let avg_rate = json["data"]["avg_rate"]
            
            let resto = RestaurantModel(id: id.intValue, name: name.stringValue, url: url.stringValue)
            resto.address = address
            resto.city = city
            resto.zipcode = zipcode
            
            resto.gps_lat = gps_lat
            resto.gps_long = gps_long
            resto.rate_count = rate_cout
            resto.pics_main = pics
            
            if card_price != nil {
                resto.card_price = card_price.intValue
            }

            if avg_rate != nil {
                resto.avg_rate = avg_rate.floatValue
            }
            
            return .Success(resto)
        }
        
        return .Failure(RestaurantError.ParsingError)
    }
}
