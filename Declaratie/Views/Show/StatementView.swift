//
//  StatementView.swift
//  Declaratie
//
//  Created by Danut Florian on 30/03/2020.
//  Copyright © 2020 Danut Florian. All rights reserved.
//

import SwiftUI
import PDFKit

struct StatementPDFView: UIViewRepresentable {
    
    var pdfName: String?
    
    func makeUIView(context: Context) -> PDFView {
        let view = PDFView()
        if let pdfName = pdfName {
            view.document = PDFManager.load(name: pdfName)
        }
        view.autoScales = true
        return view
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        print("update")
    }
}

struct StatementView: View {
    var statement: Statement?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            StatementPDFView(pdfName: statement?.pdfName)
                .edgesIgnoringSafeArea([.top, .bottom])
            VStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("⃪ inapoi").accentColor(.primary)
                    Spacer()
                }
                Spacer()
            }
            .padding(.horizontal)
        }
    }    
}

struct StatementView_Previews: PreviewProvider {
    static var previews: some View {
        StatementView()
    }
}

