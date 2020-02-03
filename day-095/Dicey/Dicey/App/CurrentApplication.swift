//
//  CurrentApplication.swift
//  Dicey
//
//  Created by CypherPoet on 2/1/20.
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
