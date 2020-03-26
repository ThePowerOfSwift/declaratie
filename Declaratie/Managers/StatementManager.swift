//
//  StatementManager.swift
//  Declaratie
//
//  Created by Danut Florian on 29/03/2020.
//  Copyright © 2020 Danut Florian. All rights reserved.
//

import UIKit
import Foundation

struct StatementManager {
    
    static func create(destinations: [Destination], reasons: [String]) -> Statement? {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let statement = Statement(context: context)
        
        statement.date = Date()
        
        let user = User()
        
        statement.firstName = user.firstName
        statement.lastName = user.lastName
        statement.birthDate = user.birthDay
        
        let address = Address()
        
        statement.address = address.address1
        statement.address2 = address.address2
        statement.city = address.city
        statement.region = address.region
        
        destinations.forEach { destination in
            let statementDestination = StatementDestination(context: context)
            statementDestination.name = destination.text
            statement.addToDestinations(statementDestination)
        }
        
        reasons.forEach { reason in
            let statementReason = StatementReason(context: context)
            statementReason.index = reason
            statement.addToReasons(statementReason)
        }
        
        do {
            try context.save()
            return statement
        } catch {
            print(error)
            return nil
        }
            
    }
    
}
