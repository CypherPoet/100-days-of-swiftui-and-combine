//
//  Appearance.swift
//  WordScramble
//
//  Created by CypherPoet on 10/23/19.
// ✌️
//

import UIKit


enum Appearance {
    
    enum Navbar {
        static let `default`: UINavigationBarAppearance = {
            let appearance = UINavigationBarAppearance()
            
            appearance.titleTextAttributes = [
                .foregroundColor: UIColor.darkText,
            ]
            
            appearance.largeTitleTextAttributes = [
                .foregroundColor: UIColor.darkText,
            ]

            appearance.configureWithTransparentBackground()
            
            return appearance
        }()
    }
    
    
    static func set(
        navBarAppearance: UINavigationBarAppearance,
        withTintColor tintColor: UIColor = .systemPink
    ) {
        UINavigationBar.appearance().tintColor = tintColor
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
}
