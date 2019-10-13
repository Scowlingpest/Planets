//
//  PlanetTableViewCell.swift
//  Planets
//
//  Created by Pip Elise Russell on 09/10/2019.
//  Copyright © 2019 Pip Elise Russell. All rights reserved.
//
import CoreData
import UIKit

protocol CollapsibleHeaderDelegate: AnyObject {

    func sectionTapped(didSelectSection section: Int)
}

class PlanetNameHeaderCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    weak var tapRecognizer: UITapGestureRecognizer?
    
    weak var delegate: CollapsibleHeaderDelegate?
    var section: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //creates the cell from the name and section number, sets the colours and label contents, also setups the tap recognizer
    func createBasicCell(name: String?, section: Int){
        self.section = section
        self.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.attributedText = NSAttributedString(string: name ?? "Planet Name")
        self.nameLabel.textColor = ThemeHelper.mainText()
        self.nameLabel.adjustsFontForContentSizeCategory = true
        self.nameLabel.sizeToFit()
        
        self.backgroundColor = ThemeHelper.mainBackground()
        
        self.layoutIfNeeded()
        
        if self.tapRecognizer == nil {
        
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapHeader(_ :)))
            addGestureRecognizer(tapRecognizer)
            self.tapRecognizer = tapRecognizer
        }
    }
    
    //when tapped, tell the delegate i've been tapped
    @objc func didTapHeader(_ sender: UIGestureRecognizer?) {
        
        if let delegate = delegate, let sectionIndex = section {
            
            delegate.sectionTapped(didSelectSection: sectionIndex)
        }
    }

    
}
