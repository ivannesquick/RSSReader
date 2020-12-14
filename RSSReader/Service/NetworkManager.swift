//
//  NetworkManager.swift
//  RSSReader
//
//  Created by Neskin Ivan on 09.12.2020.
//  Copyright © 2020 Neskin Ivan. All rights reserved.
//

import Foundation

class NetworkManager {
    
    func parseFeed(url: String, completion: @escaping(Data)->Void) {
                
        let request = URLRequest(url: URL(string: url)!)
        let urlSession = URLSession.shared
        
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            guard let data = data else {return}
            if let error = error {
                print(error.localizedDescription)
            }
                completion(data)
        }
        
        task.resume()
        
    }
}
