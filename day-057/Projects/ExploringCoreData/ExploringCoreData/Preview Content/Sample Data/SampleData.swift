//
//  SampleData.swift
//  ExploringCoreData
//
//  Created by CypherPoet on 11/21/19.
// ✌️
//

#if DEBUG

import SwiftUI
import CoreData


enum SampleMOC {
    static let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}


enum SampleCountry {
    static let usa: Country = {
        let country = Country(context: SampleMOC.viewContext)
        
        country.name = "United States of America"
        country.abbreviation = "USA"
        country.flag = "🇺🇸"
        
        return country
    }()
}

#endif
