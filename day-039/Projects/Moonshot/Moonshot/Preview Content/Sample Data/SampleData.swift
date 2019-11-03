//
//  SampleData.swift
//  Moonshot
//
//  Created by CypherPoet on 11/2/19.
// ✌️
//


#if DEBUG

import Foundation


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


enum SampleMissionState {
    static let `default` = MissionState(missions: generateSampleMissions())
}


enum SampleAppState {
    static let `default` = AppState(missionState: SampleMissionState.default)
}


enum SampleStore {
    static let `default` = AppStore(initialState: SampleAppState.default, appReducer: appReducer)
}



#endif
