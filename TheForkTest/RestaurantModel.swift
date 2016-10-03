//
//  RestaurantModel.swift
//  TheForkTest
//
//  Created by SIFFRE on 02/10/2016.
//  Copyright © 2016 Siffrej. All rights reserved.
//

import Foundation

class RestaurantModel: NSObject {
    
    /* Unique id of the restaurant */
    var id: Int!
    
    /* Url of the restaurant (on the website) : for handoff */
    var url : String!
    
    /* Name of the restaurant */
    var name : String!
    
    /* Gps lattitutde */
    var gps_lat : Double?
    
    /* Gps longitude */
    var gps_long : Double?
    
    /* Address of the restaurant */
    var address: String?
    
    /* City of the restaurant */
    var city: String?
    
    /* Zip code of city */
    var zipcode: String?
    
    /* Rate count */
    var rate_count: String?
    
    // A REVOIR: tableau d'images pour PageViewController ou ScrollView paginated !!
    var pics_main: String?
    
    var card_price: Int?
    
    var avg_rate: Float?
    
    required init(id: Int, name: String, url: String) {
        self.id = id
        self.name = name
        self.url = url
    }
    
    /* for debugging purpose */
    override var description: String {
        return "Id: \(self.id)" +
            ", name: \(self.name)"
    }
}

