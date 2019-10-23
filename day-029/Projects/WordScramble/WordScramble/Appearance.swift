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
                .foregroundColor: UIColor.systemPink,
            ]
            
            appearance.largeTitleTextAttributes = [
                .foregroundColor: UIColor.systemPink,
            ]
            
            appearance.configureWithTransparentBackground()
            
            return appearance
        }()
    }
    
    
    static func set(navBarAppearance: UINavigationBarAppearance) {
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
}
