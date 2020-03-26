//
//  FooterView.swift
//  Declaratie
//
//  Created by Danut Florian on 28/03/2020.
//  Copyright © 2020 Danut Florian. All rights reserved.
//

import SwiftUI

struct FooterView: View {
    var body: some View {
        VStack {
            Divider()
                .padding(.vertical, 5.0)
            HStack {
                Image(systemName: "info.circle.fill")
                Text("Informatiile completate sunt pastrate pe dispozitivul dumneavoastra.")
                    .font(.caption)
            }
        }
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
    }
}
