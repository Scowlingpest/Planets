//
//  CoreDataManager+Planets.swift
//  Planets
//
//  Created by Pip Elise Russell on 09/10/2019.
//  Copyright © 2019 Pip Elise Russell. All rights reserved.
//

import Foundation
import CoreData

//extension of CoreDataManager to handle to planet methods, felt it was getting untidy before
extension CoreDataManager {
    
    func askForPlanetData() {
        networkManager.fetchPlanetsInformation()
    }
    
    func savePlanet(json: [String: Any]) {
        let context = CoreDataManager.sharedInstance.persistentContainer.viewContext
        if let planetEntity = NSEntityDescription.insertNewObject(forEntityName: "Planet", into: context) as? Planet {
            
            planetEntity.name = json["name"] as? String
            planetEntity.created = json["created"] as? Date
            planetEntity.climate = json["climate"] as? String
            planetEntity.edited = json["edited"] as? Date
            planetEntity.gravity = json["gravity"] as? String
            planetEntity.terrain = json["terrain"] as? String
            planetEntity.url = json["url"] as? URL
            
            if let population = json["population"] as? Int64 {
                planetEntity.population = population
            }
            
            if let orbital = json["orbital_period"] as? Int64 {
                planetEntity.orbitalPeriod = orbital
            }
            
            if let diameter = json["diameter"] as? Int64 {
                planetEntity.diameter = diameter
            }
            
            if let rotation = json["rotation_period"] as? Int64 {
                planetEntity.rotationPeriod = rotation
            }
            
        }
        CoreDataManager.sharedInstance.saveContext()
        
    }
    
}

//in the future I expect this might be moved either back to the main file or into it's own file, but since right now it's only planets it can stay here
extension CoreDataManager: NetworkManagerDelegate {
    func savePlanetData() {
        if let planetsJson = networkManager.planetsJson {
            for planet in planetsJson {
                savePlanet(json: planet)
            }
        }
        
        NotificationCenter.default.post(name: CoreDataManager.savedAllPlanetsNotificationName, object: nil)
    }
}
