//
//  PadsListView+ViewModel+ActivityTypeFilterMode.swift
//  PadFinder
//
//  Created by CypherPoet on 1/31/20.
// ✌️
//

import Foundation


extension PadsListView.ViewModel {
    enum ActivityTypeFilterMode: String {
        case all
        case activePads
        case retiredPads
    }
}

extension PadsListView.ViewModel.ActivityTypeFilterMode: CaseIterable {}

extension PadsListView.ViewModel.ActivityTypeFilterMode: Identifiable {
    var id: String { self.rawValue }
}


// MARK: - Computeds
extension PadsListView.ViewModel.ActivityTypeFilterMode {
    var displayName: String {
        switch self {
        case .all:
            return "All"
        case .activePads:
            return "Active Pads"
        case .retiredPads:
            return "Retired Pads"
        }
    }
}
