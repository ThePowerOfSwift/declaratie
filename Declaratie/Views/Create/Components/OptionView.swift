//
//  OptionView.swift
//  Declaratie
//
//  Created by Danut Florian on 29/03/2020.
//  Copyright © 2020 Danut Florian. All rights reserved.
//

import SwiftUI

struct OptionView: View {
    
    @Binding var option: Option
        
    var body: some View {
        Button(action: {
            self.simpleSuccess()
            self.option.checked.toggle()
        }) {
            HStack {
                Text(option.text)
                    .accentColor(Color.black)
                Spacer()
                Image(systemName: option.checked ? "checkmark.circle" : "circle" )
                .font(.system(size: 30))

            }
            .padding(20)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(10)
    
        .addBorder(option.checked ? Color.blue : Color.clear, width: 4, cornerRadius: 10)
        
        .frame(minWidth: 0, maxWidth: .infinity)

        .shadow(radius: 10, x: 0, y: 10)
        .padding(.vertical, 10)
        .padding(.horizontal)
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

struct OptionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OptionView(option: .constant(Option(id: "0", text: "asigurarea de bunuri care acoperă necesitățile de bază ale persoanelor și animalelor de companie/domestice")))
        }
    }
}

extension View {
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
        return overlay(RoundedRectangle(cornerRadius: cornerRadius).strokeBorder(content, lineWidth: width))
    }
}
