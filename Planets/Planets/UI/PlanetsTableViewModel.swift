//
//  PlanetsTableViewModel.swift
//  Planets
//
//  Created by Pip Elise Russell on 11/10/2019.
//  Copyright © 2019 Pip Elise Russell. All rights reserved.
//

import Foundation
import UIKit

class PlanetTableViewModel: NSObject, UITableViewDataSource {
    var planetInfo: [String: [String: String?]]
    var rowOrder: [String]
    var planetNames: [String]
    var filteredPlanetNames: [String]
    var selectedIndex = -1
    
    override init() {
        planetInfo = [String: [String: String?]]()
        planetNames = [String]()
        let planets = CoreDataManager.sharedInstance.fetchAllPlanets()
        
        for planet in planets {
            if let name = planet.name {
                planetInfo[name] = planet.dictionaryOfValuesForDisplay()
                planetNames.append(name)
            }
        }
        filteredPlanetNames = planetNames
        rowOrder = CoreDataManager.sharedInstance.planetInfoDisplayOrder()
    }
    
    func resetSearch() {
        filteredPlanetNames = planetNames
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (selectedIndex == section) ? planetInfo[filteredPlanetNames[section]]?.count ?? 0 : 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredPlanetNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        
        let name = filteredPlanetNames[indexPath.section]
        let rowTitle = rowOrder[indexPath.row]
        cell.textLabel?.text = rowTitle
        cell.detailTextLabel?.text = planetInfo[name]?[rowTitle] ?? "-"
        
        cell.backgroundColor = ThemeHelper.mainBackground()
        cell.textLabel?.textColor = ThemeHelper.mainText()
        
        return cell
    }
    
    
    
}
