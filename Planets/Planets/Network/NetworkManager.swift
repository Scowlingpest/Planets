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
    var planetsJson : [[String: AnyObject]]?
    var next: String?
    var delegate: NetworkManagerDelegate
    
    init(delegate: NetworkManagerDelegate){
        self.delegate = delegate
    }
    
    func fetchPlanetsInformation() {
        let planetCaller = ApiCaller(address: planetAddress)
        planetCaller.fetchFromAPI(){ json, next in
            if let jsonResponse = json, let results = jsonResponse["results"] as? [[String: AnyObject]] {
                self.planetsJson = results
                self.next = next
            }

            self.delegate.savePlanetData()
        }
        
    }
}

protocol NetworkManagerDelegate {
    func savePlanetData()
}
