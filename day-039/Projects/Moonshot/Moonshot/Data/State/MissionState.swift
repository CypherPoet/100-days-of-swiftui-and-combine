//
//  MissionState.swift
//  Moonshot
//
//  Created by CypherPoet on 11/2/19.
// ✌️
//

import Foundation
import Combine
import CypherPoetSwiftUIKit_DataFlowUtils


enum MissionSideEffect: SideEffect {
    case loadMissions
    
    func mapToAction() -> AnyPublisher<AppAction, Never> {
        switch self {
        case .loadMissions:
            return DataLoader.shared
                .decodeJSON(fromFileNamed: "missions", using: MissionDecoder.default)
                .replaceError(with: [])
                .map { AppAction.mission(.setMissions($0)) }
                .eraseToAnyPublisher()
        }
    }
}


enum MissionAction {
    case setMissions(_ missions: [Mission])
}



struct MissionState {
    var missions: [Mission] = []
}


// MARK: - Reducer
let missionReducer = Reducer<MissionState, MissionAction> { state, action in
    switch action {
    case let .setMissions(missions):
        state.missions = missions
    }
}
