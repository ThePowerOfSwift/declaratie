//
//  User.swift
//  Declaratie
//
//  Created by Danut Florian on 26/03/2020.
//  Copyright © 2020 Danut Florian. All rights reserved.
//

import Foundation

struct User {
    
    var firstName: String
    var lastName: String
    var birthDate: String
    
    var exists = false
    
    var birthDay: Date {
        User.dateFormatter.date(from: birthDate) ?? Date()
    }
    
    static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }
    
    init() {
        firstName = UserDefaults.standard.string(forKey: "firstName") ?? ""
        lastName = UserDefaults.standard.string(forKey: "lastName") ?? ""
        birthDate = UserDefaults.standard.string(forKey: "birthDate") ?? ""
        
        exists = firstName != "" && lastName != "" && birthDate != ""
    }
    
    init(_ firstName: String, _ lastName: String, _ birthDate: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
    }
    
    func save() {    
        UserDefaults.standard.set(firstName, forKey: "firstName")
        UserDefaults.standard.set(lastName, forKey: "lastName")
        UserDefaults.standard.set(birthDate, forKey: "birthDate")
    }
    
    static func isValid(date: String) -> Bool {
        User.dateFormatter.date(from: date) == nil
    }
    
}
