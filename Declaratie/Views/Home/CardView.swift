//
//  CardView.swift
//  Declaratie
//
//  Created by Danut Florian on 29/03/2020.
//  Copyright © 2020 Danut Florian. All rights reserved.
//

import SwiftUI

struct CardView: View {
    
   var title = "Informare de presa: 28 martie 2020, ora 23.51"
   var color = Color("background3")
   var shadowColor = Color("backgroundShadow3")

   var body: some View {
      Text(title)
      .font(.headline)
      .fontWeight(.bold)
      .foregroundColor(.white)
      .frame(width: 150, height: 150)
      .padding(20)
      .lineLimit(nil)
      .background(color)
      .cornerRadius(20)
      .shadow(color: shadowColor, radius: 20, x: 0, y: 20)
   }

}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
