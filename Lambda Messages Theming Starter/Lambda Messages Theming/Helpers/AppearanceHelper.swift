//
//  AppearanceHelper.swift
//  Lambda Messages Theming
//
//  Created by Andrew R Madsen on 1/28/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
import UIKit

enum AppearanceHelper {
    static var lambdaRed = UIColor(red: 212.0/256/0, green: 87.0/256.0, blue: 80.0/256.0, alpha: 1.0)
    static var backgroundGray = UIColor(red: 45.0/256.0, green: 45.0/256.0, blue: 45.0/256.0, alpha: 1.0)
    
    // Font styling
    static func typerighterFont(with textStyle: UIFont.TextStyle, pointSize: CGFloat) -> UIFont {
        let font = UIFont(name: "RM Typerighter medium", size: pointSize)!
        return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font)
    }
    
    // Now styling
    static func setDarkAppearance() {
        UINavigationBar.appearance().barTintColor = backgroundGray
        UISegmentedControl.appearance().tintColor = lambdaRed
        UIBarButtonItem.appearance().tintColor = lambdaRed
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        UINavigationBar.appearance().largeTitleTextAttributes = textAttributes
        
        UITextField.appearance().tintColor = lambdaRed
        UITextView.appearance().tintColor = lambdaRed
    }
    
    // Button styling
    static func style(button: UIButton) {
        button.titleLabel?.font = typerighterFont(with: .callout, pointSize: 30)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = lambdaRed
        button.layer.cornerRadius = 8
    }
    
}
