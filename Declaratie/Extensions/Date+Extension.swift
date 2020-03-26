//
//  Date+Extension.swift
//  Declaratie
//
//  Created by Danut Florian on 13/04/2020.
//  Copyright © 2020 Danut Florian. All rights reserved.
//

import Foundation

extension Date {
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
