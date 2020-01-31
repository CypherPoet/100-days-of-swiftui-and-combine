//
//  PadsListView+ViewModel+SortingMode.swift
//  PadFinder
//
//  Created by CypherPoet on 1/31/20.
// ✌️
//

import Foundation


extension PadsListView.ViewModel {
    enum SortMode: String {
        case alphanumericAscending
        case westToEast
        case northToSouth
    }
}

extension PadsListView.ViewModel.SortMode: CaseIterable {}

extension PadsListView.ViewModel.SortMode: Identifiable {
    var id: String { self.rawValue }
}


// MARK: - Computeds
extension PadsListView.ViewModel.SortMode {
    var displayName: String {
        switch self {
        case .alphanumericAscending:
            return "A-Z"
        case .westToEast:
            return "West-East"
        case .northToSouth:
            return "North-South"
        }
    }
}
