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
            
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

            planetEntity.name = json["name"] as? String
            planetEntity.created = dateFormatter.date(from: json["created"] as? String ?? "")
            planetEntity.climate = json["climate"] as? String
            planetEntity.edited = dateFormatter.date(from: json["edited"] as? String ?? "")
            planetEntity.gravity = json["gravity"] as? String
            planetEntity.terrain = json["terrain"] as? String
            planetEntity.url = URL(string: json["url"] as? String ?? "")
            
            if let population = Int64(json["population"] as? String ?? "") {
                planetEntity.population = population
            }
            
            if let orbital = Int64(json["orbital_period"] as? String ?? "") {
                planetEntity.orbitalPeriod = orbital
            }
            
            if let diameter = Int64(json["diameter"] as? String ?? "") {
                planetEntity.diameter = diameter
            }
            
            if let rotation = Int64(json["rotation_period"] as? String ?? ""){
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
            NotificationCenter.default.post(name: CoreDataManager.retrievedDataNotificationName, object: nil)
            
        } else {
            NotificationCenter.default.post(name: CoreDataManager.failedRetrievalOfDataNotificationName, object: nil)
        }
        

    }
}
