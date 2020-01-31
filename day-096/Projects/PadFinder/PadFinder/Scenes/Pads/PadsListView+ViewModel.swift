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
    
    var pads: [Pad] {
        if case let .fetched(pads) = padsState.dataFetchingState {
            return pads
        } else {
            return []
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
