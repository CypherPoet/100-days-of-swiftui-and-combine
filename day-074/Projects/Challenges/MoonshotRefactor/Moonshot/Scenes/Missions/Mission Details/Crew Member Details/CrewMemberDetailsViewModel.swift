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
    var otherMissionRoles: [(missionName: String, role: String)] = []
    
    
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
        
        // 📝 Having this run during init allows the data to be pre-loaded
        // when the view is wrapped as a `NavigationLink` destination in our
        // Mission Details View
        self.otherMissionRoles = computeOtherMissionRoles()
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
}


private extension CrewMemberDetailsViewModel {
    
    func computeOtherMissionRoles() -> [(missionName: String, role: String)] {
        missionsState.missionsByRole(for: astronaut).compactMap { roleMissionPair in
            guard roleMissionPair.mission != mission else { return nil }

            return (roleMissionPair.mission.displayName, roleMissionPair.role)
        }
    }
}
