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
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.textColor = ThemeHelper.mainText()
        cell.backgroundColor = ThemeHelper.mainBackground()
        cell.accessoryView?.tintColor = ThemeHelper.accessory()
        
        let attributes = [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        cell.textLabel?.attributedText = NSAttributedString(string: planets[indexPath.row].name ?? "Planet" , attributes: attributes)
        
        cell.accessoryType = .disclosureIndicator
        let settingsButton = UIBarButtonItem.init(title: "Settings", style: .plain, target: self, action: #selector(onTapSettings))
//        let settingsButton = UIBarButtonItem(image: UIImage(named: "ic_settings"),
//                                             style: .plain,
//                                             target: self,
//                                             action: #selector(onTapSettings))
        
        navigationItem.leftBarButtonItem = settingsButton
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planets.count
    }
    
    @objc func onTapSettings() {
            self.performSegue(withIdentifier: "ShowSettingsView", sender: nil)

    }
    
}
