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
    var payloadManufacturerText: String { payload?.manufacturer ?? "" }
    var payloadNationalityText: String { payload?.nationality ?? "" }
    var payloadOrbitText: String { payload?.orbit ?? "" }

    
    var payloadNameText: String {
        guard let id = payload?.id else { return "" }
        return "🛰 \(id)"
    }
    
    var payloadTypeText: String {
        guard let type = payload?.payloadType else { return "" }
        
        let emoji = payload?.payloadTypeEmoji ?? ""
        
        return [emoji, type].joined(separator: " ")
    }
    

    var payloadMassText: String {
        guard let mass = payload?.mass else { return "" }
        
        return "\(mass) kg"
    }
    
    
    
    
    
    var periapsisText: String {
        guard
            let periapsis = payload?.orbitParams.periapsis,
            let formattedValue = NumberFormatters.apsisLength.string(for: periapsis)
        else { return "" }
        
        return "\(formattedValue) km"
    }
    
    
    var apoapsisText: String {
        guard
            let apoapsis = payload?.orbitParams.apoapsis,
            let formattedValue = NumberFormatters.apsisLength.string(for: apoapsis)
        else { return "" }
        
        return "\(formattedValue) km"
    }
    
    
    var orbitalDiameter: Payload.OrbitParams.Kilometers? {
        guard
            let apoapsis = payload?.orbitParams.apoapsis,
            let periapsis = payload?.orbitParams.periapsis
        else { return nil }
        
        return apoapsis + periapsis
    }
    
    
    var isShowingApsisLine: Bool { orbitalDiameter != nil }
    
    
    var apoapsisPct: CGFloat {
        guard
            let apoapsis = payload?.orbitParams.apoapsis,
            let orbitalDiameter = orbitalDiameter
        else { return 0 }
        
        return CGFloat(apoapsis / orbitalDiameter)
    }
    
    
    var periapsisPct: CGFloat {
        guard
            let periapsis = payload?.orbitParams.periapsis,
            let orbitalDiameter = orbitalDiameter
        else { return 0 }
        
        return CGFloat(periapsis / orbitalDiameter)
    }
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
