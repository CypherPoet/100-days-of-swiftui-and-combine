//
//  SampleData.swift
// ✌️
//

#if DEBUG


import SwiftUI
import CoreData


    
enum SampleMissions {
    static let telstar = Mission(
        missionID: "F4F83DE",
        name: "Telstar",
        manufacturers: [
            "SSL",
        ],
        payloadIDs: [
            SamplePayloads.telstar18V.payloadID,
            SamplePayloads.telstar19V.payloadID,
        ],
        wikipediaURL: URL(string: "https://en.wikipedia.org/wiki/Telesat"),
        websiteURL: URL(string: "https://www.telesat.com/"),
        twitterURL: nil,
        description: "Telstar 19V (Telstar 19 Vantage) is a communication satellite in the Telstar series of the Canadian satellite communications company Telesat. It was built by Space Systems Loral (MAXAR) and is based on the SSL-1300 bus. As of 26 July 2018, Telstar 19V is the heaviest commercial communications satellite ever launched, weighing at 7,076 kg (15,600 lbs) and surpassing the previous record, set by TerreStar-1 (6,910 kg/15230lbs), launched by Ariane 5ECA on 1 July 2009."
    )
}


enum SamplePayloads {
    static let telstar18V = Payload(
        payloadID: "Telstar 18V",
        payloadType: "Satellite",
        isReused: false,
        manufacturer: "SSL",
        customers: [
            "Telesat",
        ],
        nationality: "Canada",
        mass: 7060,
        oribit: "GTO",
        orbitParams: Payload.OrbitParams(
            referenceSystem: "geocentric",
            regime: "geostationary",
            longitude: 138,
            periapsis: 35780.342,
            apoapsis: 35793.581,
            epoch: Date(),
            meanAnomaly: 206.577,
            lifeSpanYears: 15,
            periodMinutes: 1436.115
        )
    )
    
    static let telstar19V = Payload(
        payloadID: "Telstar 19V",
        payloadType: "Satellite",
        isReused: false,
        manufacturer: "SSL",
        customers: [
            "Telesat",
        ],
        nationality: "Canada",
        mass: 7076,
        oribit: "GTO",
        orbitParams: Payload.OrbitParams(
            referenceSystem: "geocentric",
            regime: "geostationary",
            longitude: -65,
            periapsis: 35778.442,
            apoapsis: 35797.08,
            epoch: Date(),
            meanAnomaly: 69.209,
            lifeSpanYears: 15,
            periodMinutes: 35778.442
        )
    )
}




enum SampleAppState {
    static let noModels = AppState()
    
    static let withModels = AppState(
        missionsState: MissionsState(missions: [SampleMissions.telstar]),
        payloadsState: PayloadsState(
            payloads: [
                SampleMissions.telstar.id: [
                    SamplePayloads.telstar18V,
                    SamplePayloads.telstar19V
                ]
            ]
        )
    )
}


enum SampleStore {
    static let noModels = AppStore(initialState: SampleAppState.noModels, appReducer: appReducer)
    static let withModels = AppStore(initialState: SampleAppState.withModels, appReducer: appReducer)
}


#endif
