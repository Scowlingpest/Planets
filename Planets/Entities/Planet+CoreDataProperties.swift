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
    @NSManaged public var diameter: Int64
    @NSManaged public var edited: Date?
    @NSManaged public var gravity: String?
    @NSManaged public var name: String?
    @NSManaged public var orbitalPeriod: Int64
    @NSManaged public var population: Int64
    @NSManaged public var rotationPeriod: Int64
    @NSManaged public var surfaceWater: Int64
    @NSManaged public var terrain: String?
    @NSManaged public var url: URL?

}
