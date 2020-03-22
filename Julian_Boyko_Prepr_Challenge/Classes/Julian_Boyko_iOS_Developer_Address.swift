//
//  Julian_Boyko_iOS_Developer_Address.swift
//  Julian_Boyko_Prepr_Challenge
//
//  Created by Julian Boyko on 2020-03-21.
//  Copyright © 2020 Supreme Apps. All rights reserved.
//

import Foundation

struct Address: Codable {
    var name: String
    var streetAddress: String
    var city: String
    var province: String
    var postalCode: String
    
    init(name: String, streetAddress: String, city: String, province: String, postalCode: String) {
        self.name = name
        self.streetAddress = streetAddress
        self.city = city
        self.province = province
        self.postalCode = postalCode
    }
    
    func getAddress() -> String {
        return streetAddress + ", " + city + ", " + province + ", " + postalCode
    }
    
}

