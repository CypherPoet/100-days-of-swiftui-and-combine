//
//  CoreDataState.swift
//  Bookworm
//
//  Created by CypherPoet on 11/9/19.
// ✌️
//

import Foundation
import Combine
import CypherPoetSwiftUIKit
import CoreData


struct CoreDataState {
    var contextSaveError: Error?
}


enum CoreDataSideEffect: SideEffect {
    case save(managedObjectContext: NSManagedObjectContext)

    func mapToAction() -> AnyPublisher<AppAction, Never> {
        switch self {
        case .save(let managedObjectContext):
            // 📝 TODO: This could be a good place to call a `save(context:)` helper
            // on some kind of `CoreDataManager` class
            // (see: https://cocoacasts.com/more-core-data-and-concurrency).
            
            var saveError: Error?
            
            managedObjectContext.performAndWait {
                do {
                    try managedObjectContext.save()
                } catch {
                    saveError = error
                }
            }
            
            return Just(AppAction.coreData(.set(contextSaveError: saveError)))
                .eraseToAnyPublisher()
        }
    }
}


enum CoreDataAction {
    case set(contextSaveError: Error?)
}



// MARK: - Reducer
let coreDataReducer = Reducer<CoreDataState, CoreDataAction> { state, action in
    switch action {
    case .set(let error):
        state.contextSaveError = error
    }
}
