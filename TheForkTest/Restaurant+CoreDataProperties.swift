//
//  Restaurant+CoreDataProperties.swift
//  
//
//  Created by SIFFRE on 01/10/2016.
//
//

import Foundation
import CoreData


extension Restaurant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Restaurant> {
        return NSFetchRequest<Restaurant>(entityName: "Restaurant");
    }

    @NSManaged public var id_restaurant: Int64
    @NSManaged public var portal_url: String?
    @NSManaged public var name: String?
    @NSManaged public var gps_lat: Double
    @NSManaged public var gps_long: Double
    @NSManaged public var address: String?
    @NSManaged public var city: String?
    @NSManaged public var zipcode: String?
    @NSManaged public var rate_count: Int16
    @NSManaged public var card_price: Int16
    @NSManaged public var avg_rate: Float
    @NSManaged public var pics_main: NSObject?

}
