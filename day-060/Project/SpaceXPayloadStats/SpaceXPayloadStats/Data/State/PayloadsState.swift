//
//  PayloadsState.swift
//  SpaceXPayloadStats
//
//  Created by CypherPoet on 11/23/19.
// ✌️
//


import Foundation
import Combine
import CypherPoetSwiftUIKit


struct PayloadsState: Codable {
    var payloads: [Mission.ID: [Payload]] = [:]
}


//enum PayloadsSideEffect: SideEffect {
//
//}


enum PayloadsAction {
    case set(payloads: [Payload], forMissionID: [Mission.ID])
}



// MARK: - Reducer
let payloadsReducer = Reducer<PayloadsState, PayloadsAction> { state, action in
}
