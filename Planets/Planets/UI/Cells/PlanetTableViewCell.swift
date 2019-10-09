//
//  PlanetTableViewCell.swift
//  Planets
//
//  Created by Pip Elise Russell on 09/10/2019.
//  Copyright © 2019 Pip Elise Russell. All rights reserved.
//
import CoreData
import UIKit

class PlanetTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadInPlanet(planet: Planet){
        self.nameLabel.text = planet.name
        
        let values = planet.dictionaryOfValuesForDisplay()
        let labelKeys = values.keys
        let labels = labelKeys.sorted{$0 < $1}
        
        for label in labels {
            if let value = values[label], let notNilValue = value {
                let displayLabel = UILabel()
                displayLabel.text = "\(label): \(notNilValue)"
                displayLabel.textColor = ThemeHelper.mainText()
                stackView.addSubview(displayLabel)
            }
        }
        
    }

    
}
