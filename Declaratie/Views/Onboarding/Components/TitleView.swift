//
//  TitleView.swift
//  Declaratie
//
//  Created by Danut Florian on 28/03/2020.
//  Copyright © 2020 Danut Florian. All rights reserved.
//

import SwiftUI

struct TitleView: View {
    
    var title: String
    var subTitle: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.heavy)
            Text(subTitle)
                .font(.headline)
                .foregroundColor(.gray)
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(title: "Titlu", subTitle: "Subtitlu")
    }
}
