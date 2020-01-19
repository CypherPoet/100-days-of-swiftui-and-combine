//
//  CurrentApplication.swift
//  Flashzilla
//
//  Created by CypherPoet on 1/19/20.
// ✌️
//

import Foundation
import CypherPoetCoreDataKit_CoreDataManager


struct CurrentApplication {
    var coreDataManager: CoreDataManager
}



var CurrentApp = CurrentApplication(
    coreDataManager: .shared
)
