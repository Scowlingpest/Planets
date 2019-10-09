//
//  NetworkManager.swift
//  Planets
//
//  Created by Pip Elise Russell on 08/10/2019.
//  Copyright © 2019 Pip Elise Russell. All rights reserved.
//

import Foundation

class NetworkManager {
    let planetAddress = "https://swapi.co/api/planets/"
    var json : [String: AnyObject]?
    
    func fetchPlanetsInformation() {
        guard let planetURL = URL(string: planetAddress) else {
            return
        }
        
        let request = URLRequest(url:planetURL)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { [weak self] (planetData, response, error)  in
            if planetData != nil {
                do{
                    let planetObjects = try JSONSerialization.jsonObject(with: planetData!, options: [.mutableContainers]) as? [String: AnyObject]
                    if let results = planetObjects?["results"] as? [String: AnyObject] {
                        self?.json = results
                    }
                }catch{
                    print("Planet JSON serialising error: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
        
    }
}
