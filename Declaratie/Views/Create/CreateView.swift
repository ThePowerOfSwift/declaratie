//
//  CreateView.swift
//  Declaratie
//
//  Created by Danut Florian on 29/03/2020.
//  Copyright © 2020 Danut Florian. All rights reserved.
//

import SwiftUI


struct Option: Identifiable {
    var id: String
    var text: String
    var checked: Bool = false
}

struct Destination: Identifiable {
    var id = UUID()
    var text: String = ""
}

struct CreateView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var options = [
        Option(id: "1", text: "interes profesional, inclusiv între locuință/gospodărie și locul/locurile de desfășurare a activității profesionale și înapoi"),
        Option(id: "2", text: "asigurarea de bunuri care acoperă necesitățile de bază ale persoanelor și animalelor de companie/domestice"),
        Option(id: "3", text: "asistență medicală care nu poate fi amânată și nici realizată de la distanță"),
        Option(id: "4", text: "motive justificate, precum îngrijirea/ însoțirea unui minor/copilului, asistența persoanelor vârstnice, bolnave sau cu dizabilități ori deces al unui membru de familie"),
        Option(id: "5", text: "activitate fizică individuală (cu excluderea oricăror activități sportive de echipă/ colective) sau pentru nevoile animalelor de companie/domestice, în apropierea locuinței"),
        Option(id: "6", text: "realizarea de activități agricole"),
        Option(id: "7", text: "donarea de sânge, la centrele de transfuzie sanguină"),
        Option(id: "8", text: "scopuri umanitare sau de voluntariat"),
        Option(id: "9", text: "comercializarea de produse agroalimentare (în cazul producătorilor agricoli"),
        Option(id: "10", text: "asigurarea de bunuri necesare desfășurării activității profesionale"),
    ]
    
    @State private var destination: String = ""
    @State private var destinations: [Destination] = []
    
    private var reasons: [String] {
        options.filter { $0.checked }.map { $0.id }
    }
    
    private var validDestinations: Int {
        destinations.filter { $0.text.trimmingCharacters(in: .whitespacesAndNewlines) != "" }.count
    }
    
    var descriptionText: String {
        let destinationsText = validDestinations == 1 ? "destinație" : "destinații"
        let reasonsText = reasons.count == 1 ? "motiv" : "motive"
        
        return "Ai introdus \(validDestinations) \(destinationsText) și ați ales \(reasons.count) \(reasonsText)."
    }
    
    private var isDisabled: Bool {
        validDestinations == 0
            || reasons.count == 0
    }
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    Text("Declaratie noua")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .padding(.vertical, 30.0)
                    
                    Text("Locul deplasarii")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                    
                    Text("Precizează una sau mai multe destinații, în ordinea intenționată a traseului.")
                        .lineLimit(nil)
                        .foregroundColor(.gray)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    HStack {
                        CustomTextField(placeholder: "Tastează o destinație și apasă plus", text: $destination, isFirstResponder: true)
                            .padding(.vertical, 10)
                        Button(action: addDestination) {
                            Image(systemName: "plus.circle.fill")
                        }
                        .font(.system(size: 30))
                    }
                    .padding(.trailing)
                    
                    if destinations.count > 0 {
                        List {
                            ForEach(destinations) { destination in
                                Text(destination.text)
                                    .listRowInsets(EdgeInsets())
                            }
                            .onDelete(perform: delete)
                        }
                        .frame(height: CGFloat(destinations.count) * 46)
                        .padding(.vertical)
                        .padding(.horizontal, 0)
                    }
                    
                    Text("Motivul deplasării")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                    
                    Text("Alege unul sau mai multe motive pentru deplasarea ta.")
                        .lineLimit(nil)
                        .foregroundColor(.gray)
                        .fixedSize(horizontal: false, vertical: true)
                }
                    
                .padding(.all)
                ForEach(options.indices) { idx in
                    OptionView(option: self.$options[idx])
                }
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            
            VStack(alignment: .center, spacing: 20) {
                Text(descriptionText)
                Button(action: create) { Text("Creeaza Declarație") }
                    .disabled(isDisabled)
                    .buttonStyle(BigButtonStyle(disabled: isDisabled))
            }
            .padding(.top)
        }
        
    }
    
    func addDestination() {
        let dest = destination.trimmingCharacters(in: .whitespacesAndNewlines)
        guard dest != "" else { simpleError(); return }
        
        destinations.append(Destination(text: dest))
        destination = ""
        simpleSuccess()
    }
    
    func create() {
        guard let statement = StatementManager.create(destinations: destinations, reasons: reasons) else { return }
        let pm = PDFManager(statement: statement)
        pm.generate()
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func delete(at offsets: IndexSet) {
        destinations.remove(atOffsets: offsets)
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func simpleError() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}

