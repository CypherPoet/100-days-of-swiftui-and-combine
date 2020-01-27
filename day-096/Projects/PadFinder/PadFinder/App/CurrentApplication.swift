//
//  CurrentApplication.swift
//  PadFinder
//
//  Created by CypherPoet on 1/26/20.
// ✌️
//

import Foundation

struct CurrentApplication {
    var launchLibraryAPIService: LaunchLibraryAPIService
}


var CurrentApp = CurrentApplication(
    launchLibraryAPIService: LaunchLibraryAPIService()
)
