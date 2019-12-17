//
//  WikiPagesState.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/16/19.
// ✌️
//

import Foundation
import Combine
import CypherPoetSwiftUIKit


struct WikiPagesState {
    
    enum FetchState: Equatable {
        static func == (lhs: WikiPagesState.FetchState, rhs: WikiPagesState.FetchState) -> Bool {
            switch (lhs, rhs) {
            case (.inactive, .inactive),
                 (.fetching, .fetching),
                 (.completed, .completed):
                return true
            default:
                return false
            }
        }
        
        case inactive
        case fetching
        case completed(Result<Void, Error>)
    }

    var currentFetchState: FetchState = .inactive
}



enum WikiPagesSideEffect: SideEffect {
    case fetchPages(near: Location)
    
    
    func mapToAction() -> AnyPublisher<AppAction, Never> {
        switch self {
        case .fetchPages(let location):
            return Just(location.managedObjectContext!)
                .flatMap { context in
                    CurrentApp.wikipediaAPIService
                        .pages(near: location, usingContext: context)
                        .map { pages in
                            pages.forEach { location.addToWikiPages($0) }
                            
                            CurrentApp.coreDataManager.save(context)
                            
                            return AppAction.wikiPages(
                                .fetchStateSet(.completed(.success(())))
                            )
                        }
                        .catch { error in
                            return Just(
                                AppAction.wikiPages(
                                    .fetchStateSet(.completed(.failure(error)))
                                )
                            )
                        }
                }
                .eraseToAnyPublisher()
        }
    }
}



enum WikiPagesAction {
    case fetchStateSet(WikiPagesState.FetchState)
}



// MARK: - Reducer
let wikiPagesReducer = Reducer<WikiPagesState, WikiPagesAction> { state, action in
    switch action {
    case .fetchStateSet(let fetchState):
        state.currentFetchState = fetchState
    }
}
