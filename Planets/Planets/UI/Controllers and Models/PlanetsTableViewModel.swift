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
    //don't want anyone to change the viewmodel data directly, hence all private
    private var planetInfo: [String: [String: String?]]
    private var rowOrder: [String]
    private var planetNames: [String]
    private var filteredPlanetNames: [String]
    private var selectedIndex = -1 //-1 means no section is currently open
    
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
        //want data to appear in same order for each planet and each time they open a planet
        rowOrder = CoreDataManager.sharedInstance.planetInfoDisplayOrder()
    }
    
    //set the filtered list back to the full planet list
    func resetSearch() {
        filteredPlanetNames = planetNames
    }
    
    //set the selected index based on section
    func changeSelectedIndex(section: Int) {
        selectedIndex = (selectedIndex == section) ? -1 : section
    }
    
    func isASectionOpen() -> Bool {
        return selectedIndex != -1
    }
    
    func filterPlanets(searchText: String) {
        let searchPredicate = NSPredicate(format: "self contains [cd] %@", searchText)
        
       let items = planetNames.filter { planetName -> Bool in
            return searchPredicate.evaluate(with: planetName)
        }
        
        //want there to always be planets on screen so don't want filteredPlanets to be empty
        if !items.isEmpty {
            filteredPlanetNames = items
        }
    }
    
    func planetNameFor(section: Int) -> String {
        return filteredPlanetNames[section]
    }
    
    //if the section is open, return the row count, else if it's closed return 0
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (selectedIndex == section) ? planetInfo[filteredPlanetNames[section]]?.count ?? 0 : 0
    }
    
    //using filtered planets so that the user can search
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredPlanetNames.count
    }
    
    //using basic cells since they fit our purpose and are accessibility compliant
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        
        let name = filteredPlanetNames[indexPath.section]
        let rowTitle = rowOrder[indexPath.row]
        cell.textLabel?.text = rowTitle
        cell.detailTextLabel?.text = planetInfo[name]?[rowTitle] ?? "-"
        
        cell.backgroundColor = ThemeHelper.mainBackground()
        cell.textLabel?.textColor = ThemeHelper.mainText()
        cell.detailTextLabel?.textColor = ThemeHelper.mainText()
        
        return cell
    }
    
    
    
}
