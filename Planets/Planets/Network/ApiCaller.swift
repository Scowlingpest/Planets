//
//  ApiCaller.swift
//  Planets
//
//  Created by Pip Elise Russell on 09/10/2019.
//  Copyright © 2019 Pip Elise Russell. All rights reserved.
//

import Foundation

class ApiCaller {
    var address: String
    
    init(address: String) {
        self.address = address
    }
    
    func fetchFromAPI(completion: @escaping ([String: AnyObject]?) ->() ) {
        guard let url = URL(string: address) else {
            return
        }
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error)  in
            if data != nil {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [.mutableContainers]) as? [String: AnyObject]
                    completion(json)
                }catch{
                    print("Planet JSON serialising error: \(error.localizedDescription)")
                    completion(nil)
                }
            }
        }
        task.resume()
        
    }
}
