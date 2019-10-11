//
//  PlanetsTableViewController.swift
//  Planets
//
//  Created by Pip Elise Russell on 08/10/2019.
//  Copyright © 2019 Pip Elise Russell. All rights reserved.
//

import UIKit


class PlanetsTableViewController : UITableViewController {
    var searchController = UISearchController(searchResultsController: nil)
    var planets = CoreDataManager.sharedInstance.fetchAllPlanets()
    var filteredPlanets = CoreDataManager.sharedInstance.fetchAllPlanets()
    
    var selectedIndex = -1
    
    func reloadController(){
        searchController = UISearchController(searchResultsController: nil)
        planets = CoreDataManager.sharedInstance.fetchAllPlanets()
        filteredPlanets = planets
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        configureNavigationBar()
        
        self.tableView.register(UINib(nibName: "PlanetTableViewCell", bundle: nil), forCellReuseIdentifier: "PlanetCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.backgroundColor = ThemeHelper.secondaryBackground()
        tableView.reloadData()
    }
    
    private func configureNavigationBar() {
        //hide back button so they can't go back to the 'downloading screen'
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barStyle = UIBarStyle.black
        navigationBar?.tintColor = UIColor.white
        navigationBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.navigationItem.title = "Planets" // title of the app, so it's not localised
        
        let settingsButton = UIBarButtonItem.init(title: "Settings", style: .plain, target: self, action: #selector(onTapSettings))
        navigationItem.leftBarButtonItem = settingsButton
        
        configureSearchController()
    }
    
    private func configureSearchController() {
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.barStyle = .black
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.isActive = true
        
        navigationItem.searchController = searchController
    }
    
    //two heights, theres "take as much space as you need" and "only show the label" heights, this allows us to expand the one we are looking at
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (selectedIndex == indexPath.row) ? UITableView.automaticDimension : 36
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetCell") as! PlanetTableViewCell
        cell.nameLabel.textColor = ThemeHelper.mainText()
        let planet = filteredPlanets[indexPath.row]
        cell.loadInPlanet(planet: planet)
        
        cell.backgroundColor = ThemeHelper.mainBackground()
        
        if selectedIndex == indexPath.row {
            cell.stackView.isHidden = false
        } else {
            cell.stackView.isHidden = true
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //if they've tapped the same cell, clear our noted index and deselect it, otherwise deselect the old row and set selected to the new one
        if selectedIndex == indexPath.row {
            selectedIndex = -1
            deselectCell(indexPath: indexPath)
        } else {
            deselectCell(indexPath: IndexPath(row: selectedIndex, section: 0))
            selectedIndex = indexPath.row
        }
        
        //if we have a new cell to expand, expand it
        if let cell = tableView.cellForRow(at: indexPath) as? PlanetTableViewCell,
            selectedIndex != -1 {
            cell.stackView.isHidden = false
        }
        //update the tableView
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString("Planet Information", comment: "Planet Information")
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as? UITableViewHeaderFooterView)?.textLabel?.textColor = ThemeHelper.mainText()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPlanets.count
    }
    
    @objc func onTapSettings() {
        self.performSegue(withIdentifier: "ShowSettingsView", sender: nil)
        
    }
    
    func deselectCell(indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? PlanetTableViewCell {
            cell.stackView.isHidden = true
        }
    }
}
extension PlanetsTableViewController: UISearchControllerDelegate,UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filter(searchText: searchController.searchBar.text)
        tableView.reloadData()
    }
    
    func filter(searchText: String?) {
        if searchText == nil || searchText?.isEmpty ?? true {
            filteredPlanets = planets
        } else if let search = searchText {
            let searchPredicate = NSPredicate(format: "self contains [cd] %@", search)
            
            let items = planets.filter { planet -> Bool in
                return searchPredicate.evaluate(with: planet.name)
            }
            
            if !items.isEmpty {
                
                filteredPlanets = items
            }
        }
        
    }
}
