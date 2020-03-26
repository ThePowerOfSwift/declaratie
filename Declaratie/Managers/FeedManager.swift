//
//  Feed.swift
//  Declaratie
//
//  Created by Danut Florian on 29/03/2020.
//  Copyright © 2020 Danut Florian. All rights reserved.
//

import Foundation

struct News {
    
}

class FeedManager: NSObject, XMLParserDelegate {
    
    func load(url: String) {
        let parser = XMLParser(contentsOf: URL(string: url)!)
        parser?.delegate = self
        parser?.parse()
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print(parser)
    }
}
