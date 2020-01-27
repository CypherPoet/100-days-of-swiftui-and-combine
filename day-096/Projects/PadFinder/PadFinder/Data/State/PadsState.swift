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


struct PadsState {
    var dataFetchingState: DataFetchingState = .inactive
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
        }
    }
)

