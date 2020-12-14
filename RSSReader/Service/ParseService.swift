//
//  ParseService.swift
//  RSSReader
//
//  Created by Neskin Ivan on 09.12.2020.
//  Copyright © 2020 Neskin Ivan. All rights reserved.
//

import UIKit

class ParseService:NSObject,XMLParserDelegate {
    
    private var currentTitle = ""
    private var rssItems: [Item] = []
    private var currentElement = ""
    var currentImage = UIImage()
    var completion: (([Item]) -> Void)?
    
    
    func startParse(data: Data) {
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if currentElement == "item" {
            currentTitle = ""
        }
        
        if currentElement == "enclosure" {
            guard let urlString = attributeDict["url"] else { return }
            do {
                guard let url = URL(string: urlString) else { return }
                let data = try Data(contentsOf: url)
                currentImage = UIImage(data: data)!
            }
            catch {
                print(error)
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "title": currentTitle += string
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let rssItem = Item(title: currentTitle, image: currentImage)
            rssItems.append(rssItem)
            print(rssItems[0])
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        completion?(rssItems)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}
