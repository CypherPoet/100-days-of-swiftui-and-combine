//
//  MissionsState.swift
//
// ✌️
//

import Foundation
import Combine
import CypherPoetSwiftUIKit


struct MissionsState: Codable {
    var missions: [Mission] = []
}


enum MissionsSideEffect: SideEffect {
    case fetch
    
    func mapToAction() -> AnyPublisher<AppAction, Never> {
        switch self {
        case .fetch:
            return Dependencies.spaceXAPIService
                .fetchMissions()
                .breakpointOnError()
                .replaceError(with: [])
                .map { AppAction.missions(.set(missions: $0)) }
                .eraseToAnyPublisher()
        }
    }
}



enum MissionsAction {
    case set(missions: [Mission])
}



// MARK: - Reducer
let missionsReducer = Reducer<MissionsState, MissionsAction> { state, action in
    switch action {
    case let .set(missions):
        state.missions = missions
    }
}
