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
    @IBOutlet weak var retryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinnerView.hidesWhenStopped = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //if we have data we can show then go to application
        if !CoreDataManager.sharedInstance.fetchAllPlanets().isEmpty {
            proceedToApplication()
        } else {
            setupView()
            spinnerView.startAnimating()
            NotificationCenter.default.addObserver(self, selector: #selector(dataLoaded), name: CoreDataManager.retrievedDataNotificationName, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(dataLoaded), name: CoreDataManager.failedRetrievalOfDataNotificationName, object: nil)
            CoreDataManager.sharedInstance.askForPlanetData()
        }
    }
    
    func setupView() {
        spinnerView.isHidden = false
        statusLabel.isHidden = false
        retryButton.isHidden = true
        spinnerView.transform = CGAffineTransform(scaleX: 3, y: 3)
        spinnerView.color = ThemeHelper.mainText()
        statusLabel.textColor = ThemeHelper.mainText()
        view.backgroundColor = ThemeHelper.mainBackground()
    }
    
    @objc func dataLoaded() {
        //if it's successfully got something, continue, otherwise let the user try again
        if !CoreDataManager.sharedInstance.fetchAllPlanets().isEmpty {
            self.proceedToApplication()
        } else {
            failedToLoad()
        }
    }
    
    @objc func failedToLoad(){
        self.statusLabel.text = "Failed to download\n please try again"
        self.spinnerView.stopAnimating()
        self.retryButton.isHidden = false
        self.reloadInputViews()
    }
    
    @IBAction func retryDataDownload(_ sender: UIButton) {
        setupView()
        CoreDataManager.sharedInstance.askForPlanetData()
    }
    
    func proceedToApplication() {
        DispatchQueue.main.async { 
            self.performSegue(withIdentifier: "ShowPlanetList", sender: nil)
        }
    }
}
