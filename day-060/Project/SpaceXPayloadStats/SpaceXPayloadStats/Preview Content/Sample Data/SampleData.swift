//
//  SampleData.swift
// ✌️
//

#if DEBUG


import SwiftUI
import CoreData


enum SampleMOC {
    static let mainContext = CoreDataManager.shared.mainContext
    static let backgroundContext = CoreDataManager.shared.backgroundContext
}

    
enum SampleMissions {
    static let telstar: Mission = {
        let mission = Mission(context: SampleMOC.mainContext)

        mission.missionID = "F4F83DE"
        mission.name = "Telstar"
        mission.manufacturers = [
            "SSL",
        ]
        mission.payloadIDs = [
            SamplePayloads.telstar18V.payloadID,
            SamplePayloads.telstar19V.payloadID,
        ].compactMap { $0 }
        mission.wikipediaURLString = "https://en.wikipedia.org/wiki/Telesat"
        mission.websiteURLString = "https://www.telesat.com/"
        mission.twitterURLString = nil
        mission.missionDescription = "Telstar 19V (Telstar 19 Vantage) is a communication satellite in the Telstar series of the Canadian satellite communications company Telesat. It was built by Space Systems Loral (MAXAR) and is based on the SSL-1300 bus. As of 26 July 2018, Telstar 19V is the heaviest commercial communications satellite ever launched, weighing at 7,076 kg (15,600 lbs) and surpassing the previous record, set by TerreStar-1 (6,910 kg/15230lbs), launched by Ariane 5ECA on 1 July 2009."
        
        return mission
    }()
    
    static let idridiumNext: Mission = {
        let mission = Mission(context: SampleMOC.mainContext)

        mission.missionID = "F3364BF"
        mission.name = "Iridium NEXT"
        mission.manufacturers = [
            "Orbital ATK",
        ]
        mission.payloadIDs = [
            "Iridium NEXT 1",
            "Iridium NEXT 2",
            "Iridium NEXT 3",
            "Iridium NEXT 4",
            "Iridium NEXT 5",
            "Iridium NEXT 6",
            "Iridium NEXT 7",
            "Iridium NEXT 8",
        ]
        mission.wikipediaURLString =  "https://en.wikipedia.org/wiki/Iridium_satellite_constellation"
        mission.websiteURLString = "https://www.iridiumnext.com/"
        mission.twitterURLString = nil
        mission.missionDescription = "In 2017, Iridium began launching Iridium NEXT, a second-generation worldwide network of telecommunications satellites, consisting of 66 active satellites, with another nine in-orbit spares and six on-ground spares. These satellites will incorporate features such as data transmission that were not emphasized in the original design. The constellation will provide L-band data speeds of up to 128 kbit/s to mobile terminals, up to 1.5 Mbit/s to Iridium Pilot marine terminals, and high-speed Ka-band service of up to 8 Mbit/s to fixed/transportable terminals. The next-generation terminals and service are expected to be commercially available by the end of 2018. However, Iridium's proposed use of its next-generation satellites has raised concerns the service will harmfully interfere with GPS devices. The satellites will incorporate a secondary payload for Aireon, a space-qualified ADS-B data receiver. This is for use by air traffic control and, via FlightAware, for use by airlines. A tertiary payload on 58 satellites is a marine AIS ship-tracker receiver, for Canadian company exactEarth Ltd. Iridium can also be used to provide a data link to other satellites in space, enabling command and control of other space assets regardless of the position of ground stations and gateways."
        
        return mission
    }()
}


enum SamplePayloads {
    static let telstar18V: Payload = {
        let payload = Payload(context: SampleMOC.mainContext)
        
        payload.payloadID = "Telstar 18V"
        payload.payloadType = "Satellite"
        payload.isReused = false
        payload.manufacturer = "SSL"
        payload.customers = [
            "Telesat",
        ]
        payload.nationality = "Canada"
        payload.mass = 7060
        payload.orbit = "GTO"
        payload.orbitParams = SampleOrbitParams.fullParams1
        
        try? SampleMOC.mainContext.save()
        
        return payload
    }()
    
    
    static let telstar19V: Payload = {
        let payload = Payload(context: SampleMOC.mainContext)

        payload.payloadID = "Telstar 19V"
        payload.payloadType = "Satellite"
        payload.isReused = false
        payload.manufacturer = "SSL"
        payload.customers = [
            "Telesat",
        ]
        payload.nationality = "Canada"
        payload.mass = 7076
        payload.orbit = "GTO"
        payload.orbitParams = SampleOrbitParams.fullParams2
        
        return payload
    }()
}


enum SampleOrbitParams {
    static let fullParams1: OrbitParams = {
        let params = OrbitParams(context: SampleMOC.mainContext)
        
        params.referenceSystem = "geocentric"
        params.regime = "geostationary"
        params.longitude = 138
        params.periapsis = 5780.342
        params.apoapsis = 35793.581
        params.epoch = Date()
        params.meanAnomaly = 206.577
        params.lifespanYears = 15
        params.periodMinutes = 1436.11
        
        return params
    }()
    
    static let fullParams2: OrbitParams = {
        let params = OrbitParams(context: SampleMOC.mainContext)
        
        params.referenceSystem = "geocentric"
        params.regime = "geostationary"
        params.longitude = -65
        params.periapsis = 35778.442
        params.apoapsis = 35797.08
        params.epoch = Date()
        params.meanAnomaly = 69.209
        params.lifespanYears = 15
        params.periodMinutes = 35778.44
        
        return params
    }()
}


enum SampleAppState {
    static let `default` = AppState()
}


enum SampleStore {
    static let `default` = AppStore(initialState: SampleAppState.default, appReducer: appReducer)
}


#endif
