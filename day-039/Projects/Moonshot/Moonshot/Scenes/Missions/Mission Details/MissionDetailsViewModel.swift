//
//  MissionDetailsViewModel.swift
//  Moonshot
//
//  Created by CypherPoet on 11/3/19.
// ✌️
//

import SwiftUI
import Combine


final class MissionDetailsViewModel: ObservableObject {
    private let store: AppStore
    private let mission: Mission

    
    init(
        store: AppStore,
        mission: Mission
    ) {
        self.store = store
        self.mission = mission
    }
}


// MARK: - Computeds
extension MissionDetailsViewModel {
    
    private var astronautsState: AstronautsState {
        store.state.astronautsState
    }
    
    
    var imageName: String { mission.imageName }
    var missionDescription: String { mission.description }
    
    
    var astronautsByRole: [(role: String, astronaut: Astronaut)] {
        mission.crew.compactMap { crewMember in
            guard let astronaut = astronautsState.astronauts.first(
                where: { $0.id == crewMember.name }
            ) else {
                return nil
            }
            
            return (crewMember.role, astronaut)
        }
    }
    
    
    var missionLaunchDateText: String? {
        guard mission.launchDate != nil else { return nil }
        
        return "🚀 \(mission.formattedLaunchDate)"
    }
}
