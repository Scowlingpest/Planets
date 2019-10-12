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
    var selectedIndex = -1
    var viewModel = PlanetTableViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        configureNavigationBar()
        
        self.tableView.register(UINib(nibName: "PlanetNameHeaderCell", bundle: nil), forCellReuseIdentifier: "PlanetCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.dataSource = viewModel
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
        
        //should replace with an icon at some point, but for now the word Settings will be used
        let settingsButton = UIBarButtonItem.init(title: "Settings", style: .plain, target: self, action: #selector(onTapSettings))
        navigationItem.leftBarButtonItem = settingsButton
        
        configureSearchController()
    }
    
    //makes the search controller at the top of the planet list, we want it always visible and always on top
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
    
    @objc func onTapSettings() {
        self.performSegue(withIdentifier: "ShowSettingsView", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "PlanetCell") as? PlanetNameHeaderCell
        
        headerCell?.createBasicCell(name: viewModel.filteredPlanetNames[section], section: section)
        headerCell?.delegate = self
        return headerCell
    }
    
}
extension PlanetsTableViewController: UISearchControllerDelegate,UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filter(searchText: searchController.searchBar.text)
        tableView.reloadData()
    }
    
    func filter(searchText: String?) {
        if searchText == nil || searchText?.isEmpty ?? true {
            viewModel.resetSearch()
        } else if let search = searchText {
            let searchPredicate = NSPredicate(format: "self contains [cd] %@", search)
            
            let items = viewModel.planetNames.filter { planetName -> Bool in
                return searchPredicate.evaluate(with: planetName)
            }
            
            if !items.isEmpty {   
                viewModel.filteredPlanetNames = items
            }
        }
        
    }
}

extension PlanetsTableViewController: CollapsibleHeaderDelegate {
    func sectionTapped(didSelectSection section: Int) {
        viewModel.selectedIndex = viewModel.selectedIndex == section ? -1 : section
        tableView.reloadData()
        
    }
}
