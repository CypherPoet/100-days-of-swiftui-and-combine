//
//  CurrentApplication.swift
//  QRConnections
//
//  Created by CypherPoet on 1/9/20.
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
