//
//  ThemeHelper.swift
//  Planets
//
//  Created by Pip Elise Russell on 08/10/2019.
//  Copyright © 2019 Pip Elise Russell. All rights reserved.
//

import Foundation
import UIKit

enum ThemeType {
    
    case light
    case dark
}

class ThemeHelper {

    //current color theme, set to light mode by default
    static var currentTheme = ThemeType.light

    //colors generated from https://www.materialui.co/colors
    //color names are to correspond with the website mentioned, so blueGrey2 is 200 from the blue grey column
    private static let blueGrey2 = makeColor(red: 207, green: 216, blue: 220)
    private static let blueGrey3 = makeColor(red: 176, green: 190, blue: 197)
    private static let blueGrey6 = makeColor(red: 84, green: 110, blue: 122)
    private static let blueGrey7 = makeColor(red: 69, green: 90, blue: 100)
    
    
    class func mainText() -> UIColor {
        return checkTheme(light: UIColor.black, dark: UIColor.white)
    }
    
    class func accessory() -> UIColor {
        return checkTheme(light: UIColor.darkGray, dark: UIColor.lightGray)
    }
    
    class func mainBackground() -> UIColor {
        return checkTheme(light: blueGrey2, dark: blueGrey6)
    }
    
    class func secondaryBackground() -> UIColor {
        return checkTheme(light: UIColor.green, dark: UIColor.yellow)
//        return checkTheme(light: blueGrey3, dark: blueGrey7)
    }
    
    
    //helper method to cut down duplication, every method needs this check so i've split it out into this method
    private class func checkTheme(light: UIColor, dark: UIColor) -> UIColor {
        return (currentTheme == .light) ? light : dark
    }
    
    //helper method, making a UIColor from rgb requires dividing by 255 to avoid issues, so this method saves me typing that every time
    private class func makeColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255 ,green: green/255, blue: blue/255 ,alpha: 1.0)
    }

}

