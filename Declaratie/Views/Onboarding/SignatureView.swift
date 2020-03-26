//
//  SignatureView.swift
//  Declaratie
//
//  Created by Danut Florian on 28/03/2020.
//  Copyright © 2020 Danut Florian. All rights reserved.
//

import SwiftUI
import SwiftSignatureView


struct SignView: UIViewRepresentable {
    
    @Binding var isEmpty: Bool
    @Binding var signature: UIImage?
    
    class Coordinator: NSObject, SwiftSignatureViewDelegate {
        @Binding var isEmpty: Bool
        @Binding var signature: UIImage?
        
        init(isEmpty: Binding<Bool>, signature: Binding<UIImage?>) {
            _isEmpty = isEmpty
            _signature = signature
        }
        
        func swiftSignatureViewDidTapInside(_ view: SwiftSignatureView) {}
        
        func swiftSignatureViewDidPanInside(_ view: SwiftSignatureView, _ pan: UIPanGestureRecognizer) {
            isEmpty = false
            if let image = view.getCroppedSignature() {
                signature = image
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isEmpty: $isEmpty, signature: $signature)
    }
    
    func makeUIView(context: Context) -> SwiftSignatureView {
        let view = SwiftSignatureView()
        view.backgroundColor = .white
        view.strokeColor = UIColor(red:0.00, green:0.26, blue:0.67, alpha:1.00)

        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: SwiftSignatureView, context: Context) {
        if self.isEmpty {
            uiView.clear()
        }
    }
    
}

struct SignatureView: View {
    
    @State var isEmpty: Bool = true
    @State var signature: UIImage?
    
    @ObservedObject var state: PageViewState
    
    
    var submitDisabled: Bool {
        return isEmpty
    }
    
    var body: some View {
        VStack {
            TitleView(title: "Ultimul Pas...", subTitle: "Avem nevoie și de semnatura ta.")
            Spacer()
            SignView(isEmpty: $isEmpty, signature: $signature)
            Spacer()
            Button(action: reset) { Text("Resetează") }
                .disabled(isEmpty).padding(.vertical)
            Button(action: save) { Text("Continuă") }
                .disabled(submitDisabled)
                .buttonStyle(BigButtonStyle(disabled: submitDisabled))
            FooterView()
        }
        .padding(.all)
    }
    
    func reset() {
        isEmpty = true
    }
    
    func save() {
        ImageManager(name: "signature").save(image: signature)
        self.state.currentPage += 1
    }
}

struct SignatureView_Previews: PreviewProvider {
    static var previews: some View {
        SignatureView(state: PageViewState())
    }
}
