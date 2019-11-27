//
//  PayloadDetailsViewModel.swift
//  SpaceXPayloadStats
//
//  Created by CypherPoet on 11/24/19.
// ✌️
//

import SwiftUI
import Combine


struct PayloadDetailsViewModel {
    private(set) var payload: Payload
}


// MARK: - Computeds
extension PayloadDetailsViewModel {
    var payloadManufacturerText: String { payload.manufacturer ?? "" }
    var payloadNationalityText: String { payload.nationality ?? "" }
    var payloadOrbitText: String { payload.orbit ?? "" }

    
    var payloadNameText: String {
        guard let id = payload.payloadID else { return "" }
        return "🛰 \(id)"
    }
    
    var payloadTypeText: String {
        guard let type = payload.payloadType else { return "" }
        
        let emoji = payload.payloadTypeEmoji ?? ""
        
        return [emoji, type].joined(separator: " ")
    }
    

    var payloadMassText: String { "\(payload.mass) kg" }
    
    
    var periapsisText: String {
        guard
            let periapsis = payload.orbitParams?.periapsis,
            let formattedValue = NumberFormatters.apsisLength.string(for: periapsis)
        else { return "" }
        
        return "\(formattedValue) km"
    }
    
    
    var apoapsisText: String {
        guard
            let apoapsis = payload.orbitParams?.apoapsis,
            let formattedValue = NumberFormatters.apsisLength.string(for: apoapsis)
        else { return "" }
        
        return "\(formattedValue) km"
    }
    
    
    var orbitalDiameter: OrbitParams.Kilometers? {
        guard
            let apoapsis = payload.orbitParams?.apoapsis,
            let periapsis = payload.orbitParams?.periapsis
        else { return nil }
        
        return apoapsis + periapsis
    }
    
    
    var isShowingApsisLine: Bool { orbitalDiameter != nil }
    
    
    var apoapsisPct: CGFloat {
        guard
            let apoapsis = payload.orbitParams?.apoapsis,
            let orbitalDiameter = orbitalDiameter
        else { return 0 }
        
        return CGFloat(apoapsis / orbitalDiameter)
    }
    
    
    var periapsisPct: CGFloat {
        guard
            let periapsis = payload.orbitParams?.periapsis,
            let orbitalDiameter = orbitalDiameter
        else { return 0 }
        
        return CGFloat(periapsis / orbitalDiameter)
    }
}


// MARK: - Public Methods
extension PayloadDetailsViewModel {
}


// MARK: - Publishers
extension PayloadDetailsViewModel {
}


// MARK: - Private Helpers
private extension PayloadDetailsViewModel {
}
