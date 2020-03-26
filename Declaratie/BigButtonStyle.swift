//
//  OnboardingButton.swift
//  Declaratie
//
//  Created by Danut Florian on 28/03/2020.
//  Copyright © 2020 Danut Florian. All rights reserved.
//

import SwiftUI

struct BigButtonStyle: ButtonStyle {
    
    var disabled: Bool = true
    
    init(disabled: Bool) {
        self.disabled = disabled
    }
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(10)
            .frame(width: 200.0)
            .accentColor(.white)
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(5)
            .opacity(disabled ? 0.5 : 1.0)
    }
}
