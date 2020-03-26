//
//  PDFManager.swift
//  Declaratie
//
//  Created by Danut Florian on 29/03/2020.
//  Copyright © 2020 Danut Florian. All rights reserved.
//

import Foundation
import PDFKit

class ImageStampAnnotation: PDFAnnotation {
    var image: UIImage!
    // A custom init that sets the type to Stamp on default and assigns our Image variable
    init(with image: UIImage!, forBounds bounds: CGRect, withProperties properties: [AnyHashable : Any]?) {
      super.init(bounds: bounds, forType: PDFAnnotationSubtype.stamp,  withProperties: properties)
      self.image = image
    }
    required init?(coder aDecoder: NSCoder) {
     fatalError("init(coder:) has not been implemented")
    }

    override func draw(with box: PDFDisplayBox, in context: CGContext)   {
      // Get the CGImage of our image
      guard let cgImage = self.image.cgImage else { return }
      // Draw our CGImage in the context of our PDFAnnotation bounds
      context.draw(cgImage, in: self.bounds)
    }
}

struct PDFManager {
    
    var pdfFile: String = "Declaratie"
    var statement: Statement
    
    func generate() {
        let url = Bundle.main.url(forResource: pdfFile, withExtension: "pdf")
        let document = PDFDocument(url: url!)!
          
        let page = document.page(at: 0)
        page?
            .annotations
            .forEach { annotation in
                //                print("Annotation Name :: \(annotation.fieldName ?? "") - \(annotation.value(forAnnotationKey: .widgetValue))")
                switch annotation.fieldName {
                case "nume":
                    annotation.widgetStringValue = statement.lastName
                    break
                case "prenume":
                    annotation.widgetStringValue = statement.firstName
                    break
                case "ziua":
                    annotation.widgetStringValue = statement.day
                    break
                case "luna":
                    annotation.widgetStringValue = statement.month
                    break
                case "anul":
                    annotation.widgetStringValue = statement.year
                    break
                case "fill_8":
                    annotation.widgetStringValue = statement.addr
                    break
                case "fill_9":
                    annotation.widgetStringValue = statement.addrCont
                    break
                case "fill_10":
                    annotation.widgetStringValue = statement.destinationsString
                    break
                case "fill_1":
                    annotation.widgetStringValue = statement.date?.toString(format: "dd/MM/yyyy")
                    break
                case "Group1", "Group2", "Group3", "Group4", "Group5", "Group6", "Group7", "Group8", "Group9", "Group10":
                    annotation.buttonWidgetState = statement.hasReason(fieldName: annotation.fieldName!) ? .onState : .offState
                    break
                default:
                    break
                }
        }
        
        let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
        
        let image = ImageManager(name: "signature").load()
            
        let pageBounds = page!.bounds(for: .cropBox)
        // lets just add the image to the center of the pdf page with a width of 200px and a height of 100 px
        let imageBounds = CGRect(x: pageBounds.width - 220, y: 120,  width: 100, height: 50)
        // Now we can add our stamp as a annotation of the current pdf page
        let imageStamp = ImageStampAnnotation(with: image, forBounds: imageBounds, withProperties: nil)
        page?.addAnnotation(imageStamp)
                    
        let actualPath = resourceDocPath.appendingPathComponent("\(statement.pdfName)")
        document.write(to: actualPath)
    }
    
    static func load(name: String) -> PDFDocument? {
        let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
        let actualPath = resourceDocPath.appendingPathComponent(name)
        return PDFDocument(url: actualPath)
    }
    
    static func delete(name: String) {
        let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
        let actualPath = resourceDocPath.appendingPathComponent(name)
        do {
            try FileManager.default.removeItem(at: actualPath)
            print("File deleted")
        }
        catch {
            print("Error")
        }
    }
}

extension Statement {
    var day: String {
        birthDate?.toString(format: "dd") ?? ""
    }
    
    var month: String {
        birthDate?.toString(format: "MM") ?? ""
    }
    
    var year: String {
        birthDate?.toString(format: "yyyy") ?? ""
    }
    
    var addr: String {
        var addr = ""
        if let address = address {
            addr = address
        }
        if let address2 = address2 {
            addr = "\(addr) \(address2)"
        }
        return addr
    }
    
    var addrCont: String {
        "\(city!), \(region!)"
    }
    
    var dateTime: String {
        let format = DateFormatter()
        format.dateFormat = "dd/MM/yyyy HH:mm:ss"
        
        return format.string(from: date!)
    }
    
    var destinationsString: String {
        let set = destinations as? Set<StatementDestination> ?? []
        return set.map { $0.name! }.joined(separator: " - ")
    }
    
    var pdfName: String {
        "Declaratie-\(date!.timeIntervalSince1970).pdf"
    }
    
    var name: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.locale = Locale(identifier: "ro_RO")
        return "Declaratie \(formatter.string(for: date)!)"
    }
    
    func hasReason(fieldName: String) -> Bool {
        let index = fieldName.replacingOccurrences(of: "Group", with: "")
        let set = reasons as? Set<StatementReason> ?? []
        return set.contains { $0.index! == index }
    }
}
