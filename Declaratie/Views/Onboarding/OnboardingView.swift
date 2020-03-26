//
//  OnboardingView.swift
//  Declaratie
//
//  Created by Danut Florian on 26/03/2020.
//  Copyright © 2020 Danut Florian. All rights reserved.
//

import SwiftUI

class PageViewState: ObservableObject {
    @Published var currentPage = 0
}

struct PageViewController: UIViewControllerRepresentable {
    var controllers: [UIViewController]
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var state: PageViewState
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        return pageViewController
    }
    
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {    
        if state.currentPage >= controllers.count {
            // go to home
            UserDefaults.standard.set(true, forKey: "isOnboarded")
            self.presentationMode.wrappedValue.dismiss()
            return
        }
        
        pageViewController.setViewControllers(
            [controllers[state.currentPage]], direction: .forward, animated: state.currentPage != 0)
    }
}

struct OnboardingView: View {
    var viewControllers: [UIViewController] = []
    
    @ObservedObject var state = PageViewState()
    
    init() {
        viewControllers = [
            UIHostingController(rootView: IdentityView(state: state)),
            UIHostingController(rootView: AddressView(state: state)),
            UIHostingController(rootView: SignatureView(state: state)),
        ]
    }
    
    var body: some View {
        PageViewController(controllers: viewControllers, state: state)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
