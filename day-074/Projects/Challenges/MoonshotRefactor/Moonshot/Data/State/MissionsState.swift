//
//  MissionsState.swift
//  Moonshot
//
//  Created by CypherPoet on 11/2/19.
// ✌️
//

import Foundation
import Combine
import CypherPoetSwiftUIKit_DataFlowUtils



struct MissionsState {
    var missions: [Mission] = []
}


// MARK: - Computeds
extension MissionsState {
    
    func missions(for astronaut: Astronaut) -> [Mission] {
        missions.filter { mission in
            // The `id` property in our `Astronaut` data
            // apparently corresponds to the `name` property in our
            // `Mission.Crew`'s data 🙃.
            mission.crew.contains(where: { $0.name == astronaut.id })
        }
    }
    
    
    func missionsByRole(for astronaut: Astronaut) -> [(role: String, mission: Mission)] {
        missions.compactMap { mission in
            guard let crewMember = mission.crew.first(where: { $0.name == astronaut.id }) else {
                return nil
            }
            
            return (crewMember.role, mission)
        }
    }
}


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


// MARK: - Reducer
let missionReducer = Reducer<MissionsState, MissionAction> { state, action in
    switch action {
    case let .setMissions(missions):
        state.missions = missions
    }
}
