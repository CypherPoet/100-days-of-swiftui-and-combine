//
//  ContactsState.swift
//  QRConnections
//
//  Created by CypherPoet on 1/14/20.
// ✌️
//


import Foundation
import Combine
import CypherPoetSwiftUIKit_DataFlowUtils



struct ContactsState {
    var saveErrorMessage: String?
}



enum ContactsSideEffect: SideEffect {
    case save(_ contact: Contact)


    func mapToAction() -> AnyPublisher<AppAction, Never> {
        switch self {
        case .save(let contact):
            guard let context = contact.managedObjectContext else {
                return Just(AppAction.contacts(.saveErrorMessageSet("No managed object context found")))
                    .eraseToAnyPublisher()
            }
            
            return Just(context)
                .flatMap { context in
                    CurrentApp.coreDataManager.save(context)
                        .map { AppAction.contacts(.saveErrorMessageSet(nil)) }
                        .catch { error in
                            Just(AppAction.contacts(.saveErrorMessageSet(error.localizedDescription)))
                        }
                }
                .eraseToAnyPublisher()
        }
    }
}



enum ContactsAction {
    case saveErrorMessageSet(String?)
}


// MARK: - Reducer
let contactsReducer: Reducer<ContactsState, ContactsAction> = Reducer(
    reduce: { state, action in
        switch action {
        case .saveErrorMessageSet(let message):
            state.saveErrorMessage = message
        }
    }
)

