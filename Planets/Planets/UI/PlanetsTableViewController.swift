//
//  PlanetsTableViewController.swift
//  Planets
//
//  Created by Pip Elise Russell on 08/10/2019.
//  Copyright © 2019 Pip Elise Russell. All rights reserved.
//

import UIKit


class PlanetsTableViewController : UITableViewController {
    
    var planets = CoreDataManager.sharedInstance.fetchAllPlanets()
    
    var selectedIndex = -1
    
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
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barStyle = UIBarStyle.black
        navigationBar?.tintColor = UIColor.white
        
        navigationBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.navigationItem.title = "Planets"
        
        let settingsButton = UIBarButtonItem.init(title: "Settings", style: .plain, target: self, action: #selector(onTapSettings))
        
        navigationItem.leftBarButtonItem = settingsButton
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (selectedIndex == indexPath.row) ? UITableView.automaticDimension : 36
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetCell") as! PlanetTableViewCell
        cell.nameLabel.textColor = ThemeHelper.mainText()
        let planet = planets[indexPath.row]
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
        if selectedIndex == indexPath.row {
            selectedIndex = -1
            deselectCell(indexPath: indexPath)
        } else {
            deselectCell(indexPath: IndexPath(row: selectedIndex, section: 0))
            selectedIndex = indexPath.row
        }
        
        if let cell = tableView.cellForRow(at: indexPath) as? PlanetTableViewCell {
            cell.stackView.isHidden = false
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planets.count
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
