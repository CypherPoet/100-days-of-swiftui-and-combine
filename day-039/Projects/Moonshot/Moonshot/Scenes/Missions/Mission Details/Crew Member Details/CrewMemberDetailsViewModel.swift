//
//  CrewMemberDetailsViewModel.swift
//  Moonshot
//
//  Created by CypherPoet on 11/4/19.
// ✌️
//

import SwiftUI


struct CrewMemberDetailsViewModel {
    private let store: AppStore
    
    let astronaut: Astronaut
    let role: String
    let mission: Mission
    
    
    init(
        store: AppStore,
        astronaut: Astronaut,
        role: String,
        mission: Mission
    ) {
        self.store = store
        self.astronaut = astronaut
        self.role = role
        self.mission = mission
    }
}


// MARK: - Computeds
extension CrewMemberDetailsViewModel {
    
    private var missionsState: MissionsState { store.state.missionsState }
    
    var astronautName: String { astronaut.name }
    var astronautImageName: String { astronaut.imageName }
    var astronautDescription: String { astronaut.description }
    
    
    var roleTitleText: String {
        "Role on \(mission.displayName)"
    }
    
    
    var otherMissionRoles: [(missionName: String, role: String)]? {
        let missionsByRole = missionsState.missionsByRole(for: astronaut)
        
        guard !missionsByRole.isEmpty else { return nil }
        
        return missionsByRole.map { roleMissionPair in
            (roleMissionPair.mission.displayName, roleMissionPair.role)
        }
    }
}
