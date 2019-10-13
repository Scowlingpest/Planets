//
//  Planet+CoreDataProperties.swift
//  
//
//  Created by Pip Elise Russell on 08/10/2019.
//
//

import Foundation
import CoreData


extension Planet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Planet> {
        return NSFetchRequest<Planet>(entityName: "Planet")
    }

    @NSManaged public var climate: String?
    @NSManaged public var created: Date?
    @NSManaged public var diameter: String?
    @NSManaged public var edited: Date?
    @NSManaged public var gravity: String?
    @NSManaged public var name: String?
    @NSManaged public var orbitalPeriod: String?
    @NSManaged public var population: String?
    @NSManaged public var rotationPeriod: String?
    @NSManaged public var surfaceWater: String?
    @NSManaged public var terrain: String?
    @NSManaged public var url: URL?

    
    func dictionaryOfValuesForDisplay() -> [String: String?] {
        var dictionary = [String: String?]()
        dictionary["Climate"] = climate
        dictionary["Diameter"] = diameter
        dictionary["Gravity"] = gravity
        dictionary["Orbital Period"] = orbitalPeriod
        dictionary["Population"] = population
        dictionary["Rotation Period"] = rotationPeriod
        dictionary["Surface Water"] = surfaceWater
        dictionary["Terrain"] = terrain
        return dictionary
    }
}
