//
//  PayloadDetailsViewModel.swift
//  SpaceXPayloadStats
//
//  Created by CypherPoet on 11/24/19.
// ✌️
//

import SwiftUI
import Combine


final class PayloadDetailsViewModel: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()
    private let store: AppStore
    private let payloadID: Payload.ID
    
    
    @Published var payload: Payload?
    
    
    init(
        payloadID: Payload.ID,
        store: AppStore
    ) {
        self.payloadID = payloadID
        self.store = store
        
        setupSubscribers()
    }
}


// MARK: - Computeds
extension PayloadDetailsViewModel {
    var payloadNameText: String { payload?.id ?? "" }
}


// MARK: - Public Methods
extension PayloadDetailsViewModel {
    
    func loadPayload() {
        if let payload = store.state.payloadsState.payloadsByID[payloadID] {
            self.payload = payload
        } else {
            store.send(PayloadsSideEffect.fetchPayload(withID: payloadID))
        }
    }
}


// MARK: - Publishers
extension PayloadDetailsViewModel {
        
    private var payloadPublisher: AnyPublisher<Payload?, Never> {
        store.$state
            .map(\.payloadsState.payloadsByID)
            .map { payloadsByID in payloadsByID[self.payloadID] }
            .eraseToAnyPublisher()
    }
}


// MARK: - Private Helpers
private extension PayloadDetailsViewModel {
    
    func setupSubscribers() {
        payloadPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.payload, on: self)
            .store(in: &subscriptions)
    }
}
