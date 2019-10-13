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
    override init() {}
    
    //network manager, we only want to talk to the api from here currently so only the core data manager needs one of these
    lazy var networkManager: NetworkManager = NetworkManager(delegate: self)
    
    //persistantContainer for the application, this stores the data
   lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Planets")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
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
    
}

extension CoreDataManager {
    //notification names
    public static let retrievedDataNotificationName = Notification.Name(rawValue: "retrievedData")
    public static let failedRetrievalOfDataNotificationName = Notification.Name(rawValue: "failedRetrieval")
    
}


//fetching methods will be stored in this extension
extension CoreDataManager {
    
    func fetchAllPlanets() -> [Planet] {
        return fetchAll()
    }
    
    //rather than have multiple methods the same,i've made a generic one so we can reuse this once we have more than one kind of object
    private func fetchAll<T: NSManagedObject>() -> [T] {
        let name = String(describing: T.self)
        
        let fetchRequest = NSFetchRequest<T>(entityName: name)
        var foundItems = [T]()
        self.persistentContainer.viewContext.performAndWait {
            foundItems = try! fetchRequest.execute()
        }
        return foundItems
    }
}
