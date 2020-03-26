//
//  AddressView.swift
//  Declaratie
//
//  Created by Danut Florian on 26/03/2020.
//  Copyright © 2020 Danut Florian. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    
    @State var address1: String = ""
    @State var address2: String = ""
    @State var city: String = ""
    @State var region: String = ""
    
    @State var height: CGFloat = 0.0
    
    @ObservedObject var state: PageViewState

    
    var submitDisabled: Bool {
        address1.count < 3
            || city.count < 3
            || region.count < 3
    }
    
    init(state: PageViewState) {
        let address = Address()
        _address1 = State(initialValue: address.address1)
        _address2 = State(initialValue: address.address2)
        _city = State(initialValue: address.city)
        _region = State(initialValue: address.region)
        self.state = state
    }
    
    var body: some View {
        VStack {
            TitleView(title: "Unde locuiești?", subTitle: "Spune-mi adresa ta curentă.")
            Spacer()
            InputView(label: "Adresa", placeholder: "Strada Sanatatii, nr 1", value: $address1)
            InputView(label: "Adresa (continuare)", placeholder: "Apartament 2, Scara 4", value: $address2)
            InputView(label: "Oraș", placeholder: "Cluj-Napoca", value: $city)
            InputView(label: "Județ", placeholder: "Cluj", value: $region)
            Spacer()
            Button(action: save) { Text("Continuă") }
            .disabled(submitDisabled)
            .buttonStyle(BigButtonStyle(disabled: submitDisabled))
            FooterView()
        }
        .padding(.all)
        .padding(.bottom, self.height)
        .animation(.spring())
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                let value = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                self.height = value.height
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                self.height = 0
            }
        }
    }
    
    func save() {
        let address = Address(self.address1, self.address2, self.city, self.region)
        address.save()
        self.state.currentPage += 1
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(state: PageViewState())
    }
}
