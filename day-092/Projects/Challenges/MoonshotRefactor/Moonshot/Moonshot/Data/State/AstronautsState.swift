//
//  AstronautsState.swift
//  Moonshot
//
//  Created by CypherPoet on 11/3/19.
// ✌️
//

import Foundation
import Combine
import CypherPoetSwiftUIKit_DataFlowUtils


enum AstronautSideEffect: SideEffect {
    case loadAstronauts
    
    func mapToAction() -> AnyPublisher<AppAction, Never> {
        switch self {
        case .loadAstronauts:
            return DataLoader.shared
                .decodeJSON(fromFileNamed: "astronauts")
                .replaceError(with: [])
                .map { AppAction.astronaut(.setAstronauts($0)) }
                .eraseToAnyPublisher()
        }
    }
}


enum AstronautAction {
    case setAstronauts(_ astronauts: [Astronaut])
}



struct AstronautsState {
    var astronauts: [Astronaut] = []
}


// MARK: - Reducer
let astronautReducer = Reducer<AstronautsState, AstronautAction> { state, action in
    switch action {
    case let .setAstronauts(astronauts):
        state.astronauts = astronauts
    }
}
