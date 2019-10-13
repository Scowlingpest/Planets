//
//  SettingsViewController.swift
//  Planets
//
//  Created by Pip Elise Russell on 09/10/2019.
//  Copyright © 2019 Pip Elise Russell. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UITableViewController {
    
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var darkModeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        darkModeSwitch.isOn = ThemeHelper.currentTheme == .dark
        configureView()
    }
    
    //using static cells, and the dark theme row is a custom one so it's label gets set separately here
    func configureView(){
        tableView.backgroundColor = ThemeHelper.secondaryBackground()
        darkModeLabel.textColor = ThemeHelper.mainText()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = ThemeHelper.mainBackground()
        cell.textLabel?.textColor = ThemeHelper.mainText()
        cell.detailTextLabel?.textColor = ThemeHelper.mainText()
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as? UITableViewHeaderFooterView)?.textLabel?.textColor = ThemeHelper.mainText()
    }
    
    //if minimum iOS was 13 this would probably be set by the systems overall theme
    @IBAction func onThemeChange(_ sender: UISwitch) {
        ThemeHelper.switchTheme()
        configureView()
        tableView.reloadData()
    }
    
}
