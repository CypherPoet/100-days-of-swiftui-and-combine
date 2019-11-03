//
//  SampleData.swift
//  Moonshot
//
//  Created by CypherPoet on 11/2/19.
// ✌️
//


#if DEBUG

import Foundation


func generateSampleAstronauts() -> [Astronaut] {
    var sampleAstronauts: [Astronaut] = []
    
    _ = DataLoader.shared
        .decodeJSON(fromFileNamed: "astronauts")
        .replaceError(with: [])
        .sink { (astronauts: [Astronaut]) in
            sampleAstronauts = astronauts
        }
    
    return sampleAstronauts
}


func generateSampleMissions() -> [Mission] {
    var sampleMissions: [Mission] = []
    
    _ = DataLoader.shared
        .decodeJSON(fromFileNamed: "missions", using: MissionDecoder.default)
        .replaceError(with: [])
        .sink { (missions: [Mission]) in
            sampleMissions = missions
        }
    
    return sampleMissions
}



enum SampleAstronautsState {
    static let `default` = AstronautsState(astronauts: generateSampleAstronauts())
}


enum SampleMissionsState {
    static let `default` = MissionsState(missions: generateSampleMissions())
}


enum SampleAppState {
    static let `default` = AppState(
        astronautsState: SampleAstronautsState.default,
        missionsState: SampleMissionsState.default
    )
}


enum SampleStore {
    static let `default` = AppStore(initialState: SampleAppState.default, appReducer: appReducer)
}


#endif
