//
//  ImageTools.swift
//  Declaratie
//
//  Created by Danut Florian on 29/03/2020.
//  Copyright © 2020 Danut Florian. All rights reserved.
//

import Foundation
import UIKit

struct ImageManager {
    
    let name: String
    
    private func url() -> URL {
        let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
        let fileName = "\(name).png"
        return resourceDocPath.appendingPathComponent(fileName)
    }
    
    func save(image: UIImage?) {
        guard let data = image?.pngData() else { return }
        do {
            try data.write(to: url(), options: .atomic)
        }
        catch {
            print(error)
        }
    }
    
    func load() -> UIImage? {
        do {
            let imageData = try Data(contentsOf: url())
            return UIImage(data: imageData)
        } catch {
            print(error)
            return nil
        }
    }
}
