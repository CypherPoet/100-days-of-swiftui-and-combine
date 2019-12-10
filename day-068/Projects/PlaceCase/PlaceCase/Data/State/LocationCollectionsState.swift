//
//  LocationCollectionsState.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/9/19.
// ✌️
//


import Foundation
import Combine
import CypherPoetSwiftUIKit


struct LocationCollectionsState: Codable {
    var errorMessage: String?
}


// TODO: Remove this after debugging with it for a bit
fileprivate let defaultLocation: Location = {
    let location = Location(context: CoreDataManager.shared.backgroundContext)

    location.title = "Santorini"
    location.subtitle = "An an island in the southern Aegean Sea, speculated to be the inspiration for the city of Atlantis."
    
    location.latitude = 36.416667
    location.longitude = 25.433333
    
    return location
}()



enum LocationCollectionsSideEffect: SideEffect {
    case createDefault
//    case create(LocationCollection)
    
    func mapToAction() -> AnyPublisher<AppAction, Never> {
        switch self {
        case .createDefault:
            return Just(CoreDataManager.shared.backgroundContext)
                .map { context in
                    let collection = LocationCollection(context: context)
                    
                    collection.title = "Default Collection"
                    collection.addToLocations(defaultLocation)
                    
                    CoreDataManager.shared.save(context)
                    
                    return AppAction.locationCollections(.set(errorMesage: nil))
                }
                .eraseToAnyPublisher()
        }
    }
}



enum LocationCollectionsAction {
    case set(errorMesage: String?)
}



// MARK: - Reducer
let locationCollectionsReducer = Reducer<LocationCollectionsState, LocationCollectionsAction> { state, action in
    switch action {
    case .set(let errorMessage):
        state.errorMessage = errorMessage
    }
}
