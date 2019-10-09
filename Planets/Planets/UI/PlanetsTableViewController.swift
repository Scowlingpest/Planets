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
        
        tableView.backgroundColor = ThemeHelper.secondaryBackground()
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func configureNavigationBar() {
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barStyle = UIBarStyle.black
        navigationBar?.tintColor = UIColor.white
        
        navigationBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.navigationItem.title = "Planets"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.textColor = ThemeHelper.mainText()
        cell.backgroundColor = ThemeHelper.mainBackground()
        cell.accessoryView?.tintColor = ThemeHelper.accessory()
        
        let attributes = [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        cell.textLabel?.attributedText = NSAttributedString(string: planets[indexPath.row].name ?? "Planet" , attributes: attributes)
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planets.count
    }
    
}
