//
//  PadsState.swift
//  PadFinder
//
//  Created by CypherPoet on 1/26/20.
// ✌️
//


import Foundation
import Combine
import CypherPoetSwiftUIKit_DataFlowUtils
import CypherPoetPropertyWrappers_UserDefault


struct PadsState {
    var dataFetchingState: DataFetchingState = .inactive
    
    @UserDefault("pads-state-favorites", defaultValue: [Pad.ID]())
    var favorites: [Pad.ID]
}



extension PadsState {
    enum DataFetchingState {
        case inactive
        case fetching
        case fetched([Pad])
        case errored(Error)
    }
}


extension PadsState.DataFetchingState: Equatable {
    
    static func == (
        lhs: PadsState.DataFetchingState,
        rhs: PadsState.DataFetchingState
    ) -> Bool {
        switch (lhs, rhs) {
        case (.inactive, .inactive),
             (.fetching, .fetching),
             (.fetched, .fetched),
             (.errored, .errored):
            return true
        default:
            return false
        }
    }
    
        
}


enum PadsSideEffect: SideEffect {
    case fetchPads
    
    func mapToAction() -> AnyPublisher<AppAction, Never> {
        switch self {
        case .fetchPads:
            return CurrentApp.launchLibraryAPIService
                .pads()
                .map { AppAction.pads(.fetchedPadsSet($0)) }
                .catch { error in
                    Just(AppAction.pads(.fetchErrorSet(error)))
                }
                .eraseToAnyPublisher()
        }
    }
}



enum PadsAction {
    case padsFetchStart
    case fetchedPadsSet([Pad])
    case fetchErrorSet(Error)
    case favoriteAdded(Pad.ID)
    case favoriteRemoved(Pad.ID)
}


// MARK: - Reducer
let padsReducer: Reducer<PadsState, PadsAction> = Reducer(
    reduce: { state, action in
        switch action {
        case .fetchedPadsSet(let pads):
            state.dataFetchingState = .fetched(pads)
        case .padsFetchStart:
            state.dataFetchingState = .fetching
        case .fetchErrorSet(let error):
            state.dataFetchingState = .errored(error)
        case .favoriteAdded(let padID):
            state.favorites.append(padID)
        case .favoriteRemoved(let padID):
            state.favorites.removeAll(where: { $0 == padID })
        }
    }
)
