//
//  IdentityView.swift
//  Declaratie
//
//  Created by Danut Florian on 26/03/2020.
//  Copyright © 2020 Danut Florian. All rights reserved.
//

import SwiftUI

struct IdentityView: View {
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var birthDate: String = ""
    @State var height: CGFloat = 0.0
    
    @ObservedObject var state: PageViewState
    
    var submitDisabled: Bool {
        firstName.count < 3
            || lastName.count < 3
            || User.isValid(date: birthDate)
    }
    
    init(state: PageViewState) {
        let user = User()
        _firstName = State(initialValue: user.firstName)
        _lastName = State(initialValue: user.lastName)
        _birthDate = State(initialValue: user.birthDate)
        self.state = state
    }
    
    var body: some View {
        VStack {
            TitleView(title: "Cine ești?", subTitle: "Spune-mi ceva despre tine")
            Spacer()
            InputView(label: "Prenume", placeholder: "Dan", value: $firstName)
            InputView(label: "Nume", placeholder: "Florian", value: $lastName)
            InputView(label: "Data Nașterii", placeholder: "11/12/1987", value: $birthDate)
            Spacer()
            Button(action: {
                let user = User(self.firstName, self.lastName, self.birthDate)
                user.save()
                self.state.currentPage += 1                
            }) {
                Text("Continuă")
            }
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
}

struct IdentityView_Previews: PreviewProvider {
    static var previews: some View {
        IdentityView(state: PageViewState())
    }
}
