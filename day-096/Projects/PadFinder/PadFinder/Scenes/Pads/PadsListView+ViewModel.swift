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
        @Published var pads: [Pad] = []


        // MARK: - Init
        init(
            padsState: PadsState = .init()
        ) {
            self.padsState = padsState
            
            setupSubscribers()
        }
    }
}


// MARK: - Publishers
extension PadsListView.ViewModel {

    private var padsStatePublisher: Publishers.Share<AnyPublisher<PadsState, Never>> {
        CurrentValueSubject(padsState)
//            .print("padsStatePublisher")
            .eraseToAnyPublisher()
            .share()
    }
    
    
    private var padsFetchingStatePublisher: Publishers.Share<AnyPublisher<PadsState.DataFetchingState, Never>> {
        padsStatePublisher
            .map(\.dataFetchingState)
            .eraseToAnyPublisher()
            .share()
    }
}


// MARK: - Computeds
extension PadsListView.ViewModel {
}


// MARK: - Public Methods
extension PadsListView.ViewModel {
}



// MARK: - Private Helpers
private extension PadsListView.ViewModel {

    func setupSubscribers() {
        padsFetchingStatePublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { (fetchingState: PadsState.DataFetchingState) in
                switch fetchingState {
                case .inactive:
                    self.pads = []
                case .fetching:
                    self.pads = []
                case .fetched(let pads):
                    self.pads = pads
                case .errored(_):
                    fatalError()
                }
            })
            .store(in: &subscriptions)
    }
}
