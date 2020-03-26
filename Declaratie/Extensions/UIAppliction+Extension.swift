//
//  UIAppliction+Extension.swift
//  Declaratie
//
//  Created by Danut Florian on 13/04/2020.
//  Copyright © 2020 Danut Florian. All rights reserved.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
