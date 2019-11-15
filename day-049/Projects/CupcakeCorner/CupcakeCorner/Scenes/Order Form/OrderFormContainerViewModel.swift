//
//  OrderFormContainerViewModel.swift
//  CupcakeCorner
//
//  Created by CypherPoet on 11/13/19.
// ✌️
//


import SwiftUI
import Combine


final class OrderFormContainerViewModel: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()

    var store: AppStore
    
    
    // MARK: - Published Outputs
    @Published var isShowingAlert = false

    
    // MARK: - Init
    init(store: AppStore) {
        self.store = store
        
        setupSubscribers()
    }
}



// MARK: - Computeds
extension OrderFormContainerViewModel {
    private var ordersState: OrdersState { store.state.ordersState }
    
    private var currentAlertContent: (title: String, message: String) {
        switch (ordersState.successfullySavedOrder, ordersState.saveError) {
        case (let order?, .none):
            let cupcakesString = order.quantity == 1 ? "cupcake" : "cupcakes"
            
            return (
                title: "Order Confirmed!",
                message: "Your order of \(order.quantity) \(cupcakesString) is on its way!"
            )
        case (.none, .some):
            return (
                title: "An error occurred while processing your order.",
                message: "Please try again."
            )
        default:
            return ("", "")
        }
    }
    
    
    var currentAlertTitle: String { currentAlertContent.title }
    var currentAlertMessage: String { currentAlertContent.message }
}


// MARK: - Publishers
extension OrderFormContainerViewModel {
    
    // 🔑 Tap into the store's `state` publisher.
    private var ordersStatePublisher: AnyPublisher<OrdersState, Never> {
        store.$state
            .map(\.ordersState)
            .eraseToAnyPublisher()
    }
    
    
    private var isShowingAlertPublisher: AnyPublisher<Bool, Never> {
        ordersStatePublisher
            .map { ordersState in
                ordersState.saveError != nil || ordersState.successfullySavedOrder != nil
            }
//        .drop(untilOutputFrom: alertContentPublisher)
        .eraseToAnyPublisher()
    }
    
    
    
    private var alertContentPublisher:
        AnyPublisher<(title: String, message: String), Never>
    {
        ordersStatePublisher
            .flatMap { ordersState -> AnyPublisher<(title: String, message: String), Never> in
                if ordersState.saveError != nil {
                    return self.saveErrorAlertPublisher.eraseToAnyPublisher()
                } else if ordersState.successfullySavedOrder != nil {
                    return self.saveConfirmationAlertPublisher.eraseToAnyPublisher()
                }
                
                return Just((title: "", message: "")).eraseToAnyPublisher()
            }
        .eraseToAnyPublisher()
    }
    
    
    private var savedOrderPubilsher: AnyPublisher<Order?, Never> {
        ordersStatePublisher
            .map(\.successfullySavedOrder)
            .print("savedOrderPubilsher")
            .eraseToAnyPublisher()
    }
//
    private var saveErrorPubilsher: AnyPublisher<CupcakeAPIService.Error?, Never> {
        ordersStatePublisher
            .map(\.saveError)
            .print("saveErrorPubilsher")
            .eraseToAnyPublisher()
    }
//
    
    private var saveConfirmationAlertPublisher:
        AnyPublisher<(title: String, message: String), Never>
    {
        savedOrderPubilsher
            .compactMap { $0 }
            .map { order in
                let cupcakesString = order.quantity == 1 ? "cupcake" : "cupcakes"

                return (
                    title: "Order Confirmed!",
                    message: "Your order of \(order.quantity) \(cupcakesString) is on its way."
                )
            }
            .eraseToAnyPublisher()
    }
//
//
    private var saveErrorAlertPublisher:
        AnyPublisher<(title: String, message: String), Never>
    {
        saveErrorPubilsher
            .compactMap { $0 }
            .map {
                (
                    title: "An error occurred while attempting to place your order.",
                    message: "Please try again."
                )
            }
            .eraseToAnyPublisher()
    }
}


// MARK: - Private Helpers
private extension OrderFormContainerViewModel {

    func setupSubscribers() {
        isShowingAlertPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.isShowingAlert, on: self)
            .store(in: &subscriptions)
    }
}
