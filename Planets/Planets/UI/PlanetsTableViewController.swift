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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        configureNavigationBar()
        
        self.tableView.rowHeight = UITableView.automaticDimension
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetCell") as! PlanetTableViewCell
        cell.nameLabel.textColor = ThemeHelper.mainText()
        let planet = planets[indexPath.row]
        cell.loadInPlanet(planet: planet)
        
        cell.backgroundColor = ThemeHelper.mainBackground()
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planets.count
    }
    
    @objc func onTapSettings() {
            self.performSegue(withIdentifier: "ShowSettingsView", sender: nil)

    }
    
}
