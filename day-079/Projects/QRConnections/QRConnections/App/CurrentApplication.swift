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
    var imageFilteringService: ImageFilterService
    var userNotificationsService: UserNotificationsService
}



var CurrentApp = CurrentApplication(
    coreDataManager: .shared,
    imageFilteringService: .shared,
    userNotificationsService: .shared
)
