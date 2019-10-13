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
    var planetsJson: [[String: AnyObject]]?
    var next: String?
    var delegate: NetworkManagerDelegate
    
    init(delegate: NetworkManagerDelegate){
        self.delegate = delegate
    }
    
    func fetchPlanetsInformation() {
        fetchPlanetFrom(address: planetAddress)
    }
    
    func fetchPlanetFrom(address: String){
        let planetCaller = ApiCaller(address: address)
        planetCaller.fetchFromAPI(){ json, next in
            if let jsonResponse = json, let results = jsonResponse["results"] as? [[String: AnyObject]] {
                self.addNewPlanets(results: results)
                self.next = next
            }
            if self.next == nil {
                self.delegate.savePlanetData(manager: CoreDataManager.sharedInstance)
            } else if let address = next {
                self.fetchPlanetFrom(address: address)
            }
        }
        
    }
    
    func addNewPlanets(results: [[String: AnyObject]]) {
        if planetsJson == nil {
            self.planetsJson = results
        } else if var otherPlanets = planetsJson {
            for result in results {
                otherPlanets.append(result)
            }
            planetsJson = otherPlanets
        }
    }
}

protocol NetworkManagerDelegate {
    func savePlanetData(manager: CoreDataManager)
}
