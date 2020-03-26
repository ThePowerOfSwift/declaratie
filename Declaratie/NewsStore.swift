//
//  NewsStore.swift
//  Declaratie
//
//  Created by Danut Florian on 29/03/2020.
//  Copyright © 2020 Danut Florian. All rights reserved.
//

import SwiftUI
import Combine
import FeedKit

class NewsStore: ObservableObject {
    @Published var news: [NewsItem]
    
    init() {
        self.news = [ NewsItem(title: "loading", url: ""), NewsItem(title: "loading", url: ""), ]
    }
    
    func fetch(url: String) {
        let feedURL = URL(string: url)!
        let parser = FeedParser(URL: feedURL)
        parser.parseAsync { (result) in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let feed):
                    guard let items = feed.rssFeed?.items else { return }
                    let news = items.map{ NewsItem(title: $0.title ?? "", url: $0.link ?? "") }
                    self?.news = news
                    
                case .failure(let error):
                    print(error)
                    self?.news = []
                }
            }
        }
    }
}

struct NewsStore_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
