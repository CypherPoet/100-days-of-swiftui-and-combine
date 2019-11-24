//
//  PayloadsState.swift
//  SpaceXPayloadStats
//
//  Created by CypherPoet on 11/23/19.
// ✌️
//


import Foundation
import Combine
import CypherPoetSwiftUIKit


struct PayloadsState: Codable {
    var payloadFetchErrorMessage: String?
    var payloadsByID: [Payload.ID: Payload] = [:]
    var payloadsByMissionID: [Mission.ID: [Payload]] = [:]
}


enum PayloadsSideEffect: SideEffect {
    case fetchPayload(withID: Payload.ID)
    
    func mapToAction() -> AnyPublisher<AppAction, Never> {
        switch self {
        case let .fetchPayload(payloadID):
            return Dependencies.spaceXAPIService
                .fetchPayload(for: payloadID)
                .map { AppAction.payloads(.setPayload($0)) }
                .catch {
                    Just(AppAction.payloads(.setFetchError(message: $0.localizedDescription)))
                }
                .eraseToAnyPublisher()
        }
    }
}


enum PayloadsAction {
    case setPayload(Payload)
    case setPayloadsForMission([Payload], missionID: Mission.ID)
    case setFetchError(message: String)
}



// MARK: - Reducer
let payloadsReducer = Reducer<PayloadsState, PayloadsAction> { state, action in
    switch action {
    case .setPayload(let payload):
        state.payloadsByID[payload.id] = payload
    case .setPayloadsForMission(let payloads, let missionID):
        state.payloadsByMissionID[missionID] = payloads
    case .setFetchError(let message):
        state.payloadFetchErrorMessage = message
    }
}
