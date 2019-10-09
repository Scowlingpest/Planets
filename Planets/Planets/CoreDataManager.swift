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
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchAllPlanets() -> [Planet] {
        return fetchAll()
    }
    
    //rather than have multiple methods the same, i've made a generic one so we can reuse this once we have more than one kind of object
    private func fetchAll<T: NSManagedObject>() -> [T] {
        let name = String(describing: T.self)
        
        let fetchRequest = NSFetchRequest<T>(entityName: name)
        var foundItems = [T]()
        self.persistentContainer.viewContext.performAndWait {
            foundItems = try! fetchRequest.execute()
        }
        return foundItems
    }
    
    
    func retrieveAndLoadData() {
        networkManager.fetchPlanetsInformation()
        if let planetsJson = networkManager.planetsJson {
            for planet in planetsJson {
                savePlanet(json: planet)
            }
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
        print("Success, saving planet")
        CoreDataManager.sharedInstance.saveContext()
        
    }
}
