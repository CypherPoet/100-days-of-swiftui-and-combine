//
//  PadsListView+ViewModel.swift
//  PadFinder
//
//  Created by CypherPoet on 1/26/20.
// ✌️
//


import SwiftUI
import Combine


extension PadsListView {
    final class ViewModel: ObservableObject {
        private var subscriptions = Set<AnyCancellable>()

        private let padsState: PadsState
        
        
        // MARK: - Published Outputs
        @Published var sortingMode: SortMode = .alphanumericAscending
        @Published var activityTypeFilteringMode: ActivityTypeFilterMode = .all


        // MARK: - Init
        init(
            padsState: PadsState
        ) {
            self.padsState = padsState
            
            setupSubscribers()
        }
    }
}


// MARK: - Publishers
extension PadsListView.ViewModel {
}


// MARK: - Computeds
extension PadsListView.ViewModel {
    
    private var pads: [Pad] {
        if case let .fetched(pads) = padsState.dataFetchingState {
            return pads
        } else {
            return []
        }
    }
    
    
    private var sortedPads: [Pad] {
        switch sortingMode {
        case .alphanumericAscending:
            return pads.sorted { $0.name < $1.name }
        case .westToEast:
            return pads.sorted { $0.longitude < $1.longitude }
        case .northToSouth:
            return pads.sorted { $0.latitude < $1.latitude }
        }
    }
    
    
    var displayedPads: [Pad] {
        switch activityTypeFilteringMode {
        case .all:
            return sortedPads
        case .activePads:
            return sortedPads.filter { $0.isRetired == false }
        case .retiredPads:
            return sortedPads.filter { $0.isRetired }
        }
    }
}


// MARK: - Public Methods
extension PadsListView.ViewModel {
}


// MARK: - Private Helpers
private extension PadsListView.ViewModel {

    func setupSubscribers() {
    }
}
