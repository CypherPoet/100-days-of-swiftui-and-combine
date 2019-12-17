//
//  CurrentApplication.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/14/19.
// ✌️
//

import Foundation


struct CurrentApplication {
    var coreDataManager: CoreDataManager
    var wikipediaAPIService: WikipediaAPIService
}


var CurrentApp = CurrentApplication(
    coreDataManager: .shared,
    
    wikipediaAPIService: WikipediaAPIService(
        queue: DispatchQueue(label: "WikipediaAPI", qos: .userInitiated)
    )
)
