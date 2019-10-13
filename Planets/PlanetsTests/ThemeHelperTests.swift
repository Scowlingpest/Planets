//
//  ThemeHelperTests.swift
//  PlanetsTests
//
//  Created by Pip Elise Russell on 12/10/2019.
//  Copyright © 2019 Pip Elise Russell. All rights reserved.
//

import XCTest
@testable import Planets

class ThemeHelperTests: XCTestCase {
    
    override class func tearDown() {
        ThemeHelper.currentTheme = ThemeType(rawValue: UserDefaults.standard.string(forKey: ThemeHelper.themeSetKey) ?? "light")
        
    }
    
    func testThemeHelperLight() {
        ThemeHelper.currentTheme = .light
        
        XCTAssertEqual(ThemeHelper.mainText(), UIColor.black)
        XCTAssertEqual(ThemeHelper.mainBackground(), UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0))
        XCTAssertEqual(ThemeHelper.secondaryBackground(), UIColor(red: 191/255, green: 191/255, blue: 191/255, alpha: 1.0))
        
    }
    
    func testThemeHelperDark() {
        ThemeHelper.currentTheme = .dark
        
        XCTAssertEqual(ThemeHelper.mainText(), UIColor.white)
        XCTAssertEqual(ThemeHelper.mainBackground(), UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1.0))
        XCTAssertEqual(ThemeHelper.secondaryBackground(), UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0))
        
    }
}
