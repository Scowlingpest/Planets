//
//  MockCoreDataManager.swift
//  PlanetsTests
//
//  Created by Pip Elise Russell on 13/10/2019.
//  Copyright © 2019 Pip Elise Russell. All rights reserved.
//

import CoreData
import Foundation
@testable import Planets

class MockCoreDataManager: CoreDataManager {
    
    override init() {
        super.init()
        
        persistentContainer = mockContainer
        
    }

   lazy var mockContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Planets")
    let description = NSPersistentStoreDescription()
    description.type = NSInMemoryStoreType
    description.shouldAddStoreAsynchronously = false
    
    container.persistentStoreDescriptions = [description]
    
       container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        precondition(storeDescription.type == NSInMemoryStoreType)
           if let error = error as NSError? {
               print("Unresolved error \(error), \(error.userInfo)")
           }
       })
       return container
   }()
    
}
