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
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !CoreDataManager.sharedInstance.fetchAllPlanets().isEmpty {
            proceedToApplication()
        } else {
            setupView()
            spinnerView.startAnimating()
            NotificationCenter.default.addObserver(self, selector: #selector(dataLoaded), name: CoreDataManager.savedAllPlanetsNotificationName, object: nil)
            CoreDataManager.sharedInstance.askForPlanetData()
            setupView()
        }
    }
    
    func setupView() {
        spinnerView.isHidden = false
        statusLabel.isHidden = false
        spinnerView.transform = CGAffineTransform(scaleX: 3, y: 3)
        spinnerView.color = ThemeHelper.mainText()
        statusLabel.textColor = ThemeHelper.mainText()
        view.backgroundColor = ThemeHelper.mainBackground()
    }
    
    @objc func dataLoaded() {
            if !CoreDataManager.sharedInstance.fetchAllPlanets().isEmpty {
                self.proceedToApplication()
            } else {
                self.statusLabel.text = "Failed!!!"
                self.statusLabel.reloadInputViews()
            }
        
    }
    
    func proceedToApplication() {
        DispatchQueue.main.async {
            
            self.performSegue(withIdentifier: "ShowPlanetList", sender: nil)
        }
    }
}
