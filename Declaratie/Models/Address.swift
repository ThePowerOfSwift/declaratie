//
//  Address.swift
//  Declaratie
//
//  Created by Danut Florian on 26/03/2020.
//  Copyright © 2020 Danut Florian. All rights reserved.
//

import Foundation

struct Address {
    
    var address1: String
    var address2: String
    var city: String
    var region: String
    
    var exists = false
    
    init() {
        address1 = UserDefaults.standard.string(forKey: "address1") ?? ""
        address2 = UserDefaults.standard.string(forKey: "address2") ?? ""
        city = UserDefaults.standard.string(forKey: "city") ?? ""
        region = UserDefaults.standard.string(forKey: "region") ?? ""
        
        exists = address1 != "" && address2 != "" && city != "" && region != ""
    }
    
    init(_ address1: String, _ address2: String, _ city: String, _ region: String) {
        self.address1 = address1
        self.address2 = address2
        self.city = city
        self.region = region
    }
    
    func save() {
        UserDefaults.standard.set(address1, forKey: "address1")
        UserDefaults.standard.set(address2, forKey: "address2")
        UserDefaults.standard.set(city, forKey: "city")
        UserDefaults.standard.set(region, forKey: "region")
    }
    
}
