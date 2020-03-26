//
//  DestinationView.swift
//  Declaratie
//
//  Created by Danut Florian on 29/03/2020.
//  Copyright © 2020 Danut Florian. All rights reserved.
//

import SwiftUI

struct DestinationView: View {
    var placeholder: String = "Scrie o destinatie"
    var action: () -> Void
    
    @Binding var destination: String
    
    var body: some View {
        HStack(spacing: 10) {
            TextField(placeholder, text: $destination)
            Button(action: action) {
                Image(systemName: "plus.circle.fill")
            }
        }
    }
    
    func onDelete() {
        
    }
    
    
}

struct DestinationView_Previews: PreviewProvider {
    static var previews: some View {
        DestinationView(action: {}, destination: .constant(""))
    }
}
