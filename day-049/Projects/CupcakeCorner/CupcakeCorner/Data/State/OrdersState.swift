//
//  PricesState.swift
//
//  Created by CypherPoet on 11/9/19.
// ✌️
//

import Foundation
import Combine
import CypherPoetSwiftUIKit


struct OrdersState {
    var currentOrder: Order? = nil
    var lastSavedOrder: Order? = nil
    var saveError: CupcakeAPIService.Error? = nil
}


enum OrdersSideEffect: SideEffect {
    case saveCurrent(order: Order)


    func mapToAction() -> AnyPublisher<AppAction, Never> {
        switch self {
        case .saveCurrent(let order):
            return Dependencies.cupcakeAPIService
                .save(order)
                .map { AppAction.orders(.saved(order: $0)) }
                .catch { error in
                    Just(AppAction.orders(.saveFailed(error: error)))
                }
                .eraseToAnyPublisher()
        }
    }
}



enum OrdersAction {
    case saved(order: Order)
    case saveFailed(error: CupcakeAPIService.Error)
}



// MARK: - Reducer
let ordersReducer = Reducer<OrdersState, OrdersAction> { state, action in
    switch action {
    case .saved(let order):
        state.currentOrder = nil
        state.saveError = nil
        state.lastSavedOrder = order
    case .saveFailed(let error):
        state.saveError = error
    }
}
