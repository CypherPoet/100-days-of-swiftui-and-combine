//
//  MissionsState.swift
//
// ✌️
//

import Foundation
import Combine
import CypherPoetSwiftUIKit


struct MissionsState: Codable {
    var missionsFetchErrorMessage: String?
}


enum MissionsSideEffect: SideEffect {
    case fetch
    
    func mapToAction() -> AnyPublisher<AppAction, Never> {
        switch self {
        case .fetch:
            let context = CoreDataManager.shared.backgroundContext
            
            return Dependencies.spaceXAPIService
                .fetchMissions(using: context)
                .map { _ in
                    CoreDataManager.shared.save(context)
                    return AppAction.missions(.set(fetchErrorMessage: nil))
                }
                .catch { error in
                    Just(AppAction.missions(.set(fetchErrorMessage: error.errorDescription)))
                }
                .eraseToAnyPublisher()
        }
    }
}



enum MissionsAction {
    case set(fetchErrorMessage: String?)
}



// MARK: - Reducer
let missionsReducer = Reducer<MissionsState, MissionsAction> { state, action in
    switch action {
    case .set(let fetchErrorMessage):
        state.missionsFetchErrorMessage = fetchErrorMessage
    }
}
