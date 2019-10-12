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
            let jsonFormatter = JsonFormatter()
            
            planetEntity.name = jsonFormatter.jsonToString(json: json["name"])
            planetEntity.created = jsonFormatter.jsonToDate(json: json["created"])
            planetEntity.climate = jsonFormatter.jsonToString(json: json["climate"])
            planetEntity.edited = jsonFormatter.jsonToDate(json: json["edited"])
            planetEntity.gravity = jsonFormatter.jsonToString(json: json["gravity"])
            planetEntity.terrain = jsonFormatter.jsonToString(json: json["terrain"])
            planetEntity.url = jsonFormatter.jsonToURL(json: json["url"])
            
            planetEntity.population = jsonFormatter.jsonToInt(json: json["population"])
            planetEntity.orbitalPeriod = jsonFormatter.jsonToInt(json: json["orbital_period"])
            planetEntity.diameter = jsonFormatter.jsonToInt(json: json["diameter"])
            planetEntity.rotationPeriod = jsonFormatter.jsonToInt(json: json["rotation_period"])
            planetEntity.surfaceWater = jsonFormatter.jsonToInt(json: json["surface_water"])
            
            
        }
        CoreDataManager.sharedInstance.saveContext()
        
    }
    
    func planetInfoDisplayOrder() ->[String] {
        return ["Rotation Period",
                "Orbital Period",
                "Diameter",
                "Climate",
                "Gravity",
                "Terrain",
                "Surface Water",
                "Population"]
    }
    
}

//in the future I expect this might be moved either back to the main file or into it's own file, but since right now it's only planets it can stay here
extension CoreDataManager: NetworkManagerDelegate {
    func savePlanetData() {
        if let planetsJson = networkManager.planetsJson {
            for planet in planetsJson {
                savePlanet(json: planet)
            }
            NotificationCenter.default.post(name: CoreDataManager.retrievedDataNotificationName, object: nil)
            
        } else {
            NotificationCenter.default.post(name: CoreDataManager.failedRetrievalOfDataNotificationName, object: nil)
        }
        
        
    }
}
