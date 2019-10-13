//
//  ThemeHelper.swift
//  Planets
//
//  Created by Pip Elise Russell on 08/10/2019.
//  Copyright © 2019 Pip Elise Russell. All rights reserved.
//

import Foundation
import UIKit

enum ThemeType: String {
    
    case light
    case dark
}

class ThemeHelper {
    //current color theme, set to light mode by default
    static var currentTheme = ThemeType(rawValue: UserDefaults.standard.string(forKey: ThemeHelper.themeSetKey) ?? "light")
    
    public static let themeSetKey = "planets.theme"

    //for the following colous, the number at the end of the name is the percentage of that colour
    //so lightGrey85 is 85% white (i've called it light/dark grey because white 85 sounded off)
    
    //main background colours
    private static let lightGrey85 = makeColor(red: 217, green: 217, blue: 217)
    private static let darkGrey30 = makeColor(red: 77, green: 77, blue: 77)
    
    //secondary background colours
    private static let lightGrey75 = makeColor(red: 191, green: 191, blue: 191)
    private static let darkGrey20 = makeColor(red: 51, green: 51, blue: 51)
    
    private static let blue45 = makeColor(red: 0, green: 57, blue: 230)
    
    
    class func mainText() -> UIColor {
        return checkTheme(light: UIColor.black, dark: UIColor.white)
    }
    
    class func mainBackground() -> UIColor {
        return checkTheme(light: lightGrey85, dark: darkGrey30)
    }
    
    class func secondaryBackground() -> UIColor {
        return checkTheme(light: lightGrey75, dark: darkGrey20)
    }
    
    class func switchTheme(){
        self.currentTheme = (currentTheme == .light) ? .dark : .light
        
        UserDefaults.standard.set(currentTheme?.rawValue, forKey: themeSetKey)
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

