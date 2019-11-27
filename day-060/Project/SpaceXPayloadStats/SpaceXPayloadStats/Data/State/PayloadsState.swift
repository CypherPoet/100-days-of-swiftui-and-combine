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
}


enum PayloadsSideEffect: SideEffect {
    case fetchPayloads(for: Mission)
//    case fetchPayload(withID: String)

    
    func mapToAction() -> AnyPublisher<AppAction, Never> {
        let context = CoreDataManager.shared.backgroundContext
        
        switch self {
        case let .fetchPayloads(mission):
            return Dependencies.spaceXAPIService
                .fetchPayloads(with: mission.payloadIDs ?? [], using: context)
                .map { _ in
                    CoreDataManager.shared.save(context)
                    return AppAction.payloads(.set(fetchErrorMessage: nil))
                }
                .catch { error in
                    Just(AppAction.payloads(.set(fetchErrorMessage: error.errorDescription)))
                }
                .eraseToAnyPublisher()
        }
    }
}


enum PayloadsAction {
    case set(fetchErrorMessage: String?)
}



// MARK: - Reducer
let payloadsReducer = Reducer<PayloadsState, PayloadsAction> { state, action in
    switch action {
    case .set(let fetchErrorMessage):
        state.payloadFetchErrorMessage = fetchErrorMessage
    }
}
