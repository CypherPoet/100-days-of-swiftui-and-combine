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
    
    static let idridiumNext = Mission(
        missionID: "F3364BF",
        name: "Iridium NEXT",
        manufacturers: [
            "Orbital ATK",
        ],
        payloadIDs: [
            "Iridium NEXT 1",
            "Iridium NEXT 2",
            "Iridium NEXT 3",
            "Iridium NEXT 4",
            "Iridium NEXT 5",
            "Iridium NEXT 6",
            "Iridium NEXT 7",
            "Iridium NEXT 8",
        ],
        wikipediaURL: URL(string: "https://en.wikipedia.org/wiki/Iridium_satellite_constellation"),
        websiteURL: URL(string: "https://www.iridiumnext.com/"),
        twitterURL: nil,
        description: "In 2017, Iridium began launching Iridium NEXT, a second-generation worldwide network of telecommunications satellites, consisting of 66 active satellites, with another nine in-orbit spares and six on-ground spares. These satellites will incorporate features such as data transmission that were not emphasized in the original design. The constellation will provide L-band data speeds of up to 128 kbit/s to mobile terminals, up to 1.5 Mbit/s to Iridium Pilot marine terminals, and high-speed Ka-band service of up to 8 Mbit/s to fixed/transportable terminals. The next-generation terminals and service are expected to be commercially available by the end of 2018. However, Iridium's proposed use of its next-generation satellites has raised concerns the service will harmfully interfere with GPS devices. The satellites will incorporate a secondary payload for Aireon, a space-qualified ADS-B data receiver. This is for use by air traffic control and, via FlightAware, for use by airlines. A tertiary payload on 58 satellites is a marine AIS ship-tracker receiver, for Canadian company exactEarth Ltd. Iridium can also be used to provide a data link to other satellites in space, enabling command and control of other space assets regardless of the position of ground stations and gateways."
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
        orbit: "GTO",
        orbitParams: Payload.OrbitParams(
            referenceSystem: "geocentric",
            regime: "geostationary",
            longitude: 138,
            periapsis: 5780.342,
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
        orbit: "GTO",
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
            payloadsByID: [
                SamplePayloads.telstar18V.id: SamplePayloads.telstar18V,
                SamplePayloads.telstar19V.id: SamplePayloads.telstar19V,
            ],
            payloadsByMissionID: [
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
