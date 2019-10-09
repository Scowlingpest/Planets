//
//  CoreDataManager.swift
//  Planets
//
//  Created by Pip Elise Russell on 08/10/2019.
//  Copyright © 2019 Pip Elise Russell. All rights reserved.
//

import CoreData
import Foundation

class CoreDataManager: NSObject {
    static let sharedInstance = CoreDataManager()
    private override init() {}
    
    //network manager, we only want to talk to the api from here currently so only the core data manager needs one of these
    lazy var networkManager: NetworkManager = NetworkManager()
    
    //persistantContainer for the application, this stores the data
   lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Planets")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    func retrieveAndLoadData() {
        networkManager.fetchPlanetsInformation()
        if let json = networkManager.json {
            print("hello")
        }
    }
    
    private func savePlanet(json: [String: Any]) {
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
