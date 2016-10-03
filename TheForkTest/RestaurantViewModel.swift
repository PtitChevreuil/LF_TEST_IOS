//
//  RestaurantViewModel.swift
//  TheForkTest
//
//  Created by SIFFRE on 02/10/2016.
//  Copyright © 2016 Siffrej. All rights reserved.
//

import Foundation

class RestaurantViewModel: NSObject {
    
    let resto: RestaurantModel
    
    // MARK - Initialization
    
    init(withRestaurant resto: RestaurantModel) {
        self.resto = resto
    }
    
    // MARK - Labels decorations
    
    func addressLabelText() -> String {
        
        guard let adress = resto.address, let zip = resto.zipcode, let city = resto.city else {
            return ""
        }
        return adress + " " + zip + " " + city
    }
    
    func feedbackLabelText() -> String {
        
        guard let ndF = resto.rate_count else {
            return ""
        }
        return ndF + " avis LaFourchette"
    }
    
    func avgPriceLabelText() -> String {
        guard let price = resto.card_price else {
            return "Prix moyen non disponible"
        }
        
        // currency check needed in a real app
        return "Prix moyen à la carte de ce restaurant: " + String(price) + "€"
    }
    
    func ratingLabelText() -> String {
        guard let rate = resto.avg_rate, rate <= 10, rate >= 0 else {
            return ""
        }
        
        return String(format: "%.1f", rate) + "/10"
    }
}
