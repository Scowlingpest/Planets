//
//  PlanetCoreDataTests.swift
//  PlanetsTests
//
//  Created by Pip Elise Russell on 12/10/2019.
//  Copyright © 2019 Pip Elise Russell. All rights reserved.
//

import XCTest
import CoreData
@testable import Planets

class PlanetCoreDataTests: XCTestCase {

    var manager: CoreDataManager!
    
    override func setUp() {
        super.setUp()
        manager = CoreDataManager()
        if manager.fetchAllPlanets().count != 0 {
            tearDown()
        }
    }
    
    override func tearDown() {
        let delete = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "Planet"))
        do {
            try manager.persistentContainer.viewContext.execute(delete)
        } catch {
            print("Tests are broken, please fix them")
        }
    }

    func testDictionaryOfValuesForDisplay() {
        let planet = ["name": "Alterra",
                      "rotation_period": "15",
                      "orbital_period": "768",
                      "diameter": "25000",
                      "climate": "dead",
                      "gravity": "3 standard",
                      "terrain": "wasteland",
                      "surface_water": "0",
                      "population": "5000",
                      "created": "2014-12-10T11:35:48.479000Z",
                      "edited": "2014-12-20T20:58:18.420000Z",
                      "url": "https://swapi.co/api/planets/1/"] as [String : Any]
        
        let comparison = ["Climate": "dead",
                          "Diameter": "25000",
                          "Gravity": "3 standard",
                          "Orbital Period": "768",
                          "Population": "5000",
                          "Rotation Period": "15",
                          "Surface Water": "0",
                          "Terrain": "wasteland"]
        manager.savePlanet(json: planet)
        
        XCTAssert(manager.fetchAllPlanets().count == 1)
        let savedPlanet = manager.fetchAllPlanets()[0]
        
        let test = savedPlanet.dictionaryOfValuesForDisplay()
        XCTAssertEqual(test, comparison)
        
    }

}
