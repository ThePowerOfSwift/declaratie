//
//  InputView.swift
//  Declaratie
//
//  Created by Danut Florian on 28/03/2020.
//  Copyright © 2020 Danut Florian. All rights reserved.
//

import SwiftUI

struct InputView: View {
    var label: String
    var placeholder: String
    @Binding var value: String
    
    var body: some View {
        HStack {
            Text(label).font(.callout)
            Spacer()
            TextField(placeholder, text: $value).fixedSize().multilineTextAlignment(.trailing)
        }.padding(.vertical, 10.0)
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(label: "Name", placeholder: "Type the name...", value: .constant(""))
    }
}
