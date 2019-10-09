//
//  DownloadIndicatorViewController.swift
//  Planets
//
//  Created by Pip Elise Russell on 09/10/2019.
//  Copyright © 2019 Pip Elise Russell. All rights reserved.
//

import Foundation
import UIKit


class DownloadIndicatorViewController: UIViewController {
    
    override func viewDidLoad() {
        if !CoreDataManager.sharedInstance.fetchAllPlanets().isEmpty {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "PlanetsListTableView") as! PlanetsTableViewController
                    self.present(newViewController, animated: true, completion: nil)
        } else {
            CoreDataManager.sharedInstance.retrieveAndLoadData()
        }
    }
}
