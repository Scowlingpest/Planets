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
    
    func configureView(){
        darkModeLabel.textColor = ThemeHelper.mainText()
        tableView.backgroundColor = ThemeHelper.secondaryBackground()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = ThemeHelper.mainBackground()
    }
    
    @IBAction func onThemeChange(_ sender: UISwitch) {
        ThemeHelper.currentTheme = sender.isOn ? .dark : .light
        configureView()
        tableView.reloadData()
    }
    
}
