//
//  FlagsStore.swift
//  GuessTheFlag
//
//  Created by CypherPoet on 10/13/19.
// ✌️
//

import Foundation
import Combine


final class FlagsStore: ObservableObject {
    @Published var flags: [CityFlag]
    
    init(flags: [CityFlag] = defaultFlags) {
        self.flags = flags
    }
}


extension FlagsStore {
    static let defaultFlags: [CityFlag] = [
        .amsterdam,
        .berlin,
        .chicago,
        .denver,
        .hongKong,
        .london,
        .losAngeles,
        .paris,
        .riga,
        .toronto,
        .washingtonDC,
    ]
}
