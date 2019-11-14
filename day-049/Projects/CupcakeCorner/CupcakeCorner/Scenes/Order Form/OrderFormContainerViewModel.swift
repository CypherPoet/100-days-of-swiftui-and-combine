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
    
    
    // MARK: - Published Properties
    @Published var isShowingSaveConfirmationAlert = false
    @Published var isShowingSaveErrorAlert = false
    @Published var saveConfirmationMessage: String = ""
    @Published var saveErrorMessage: String = ""

    // MARK: - Init
    init(store: AppStore) {
        self.store = store
        
        setupSubscribers()
    }
}


// MARK: - Publishers
extension OrderFormContainerViewModel {
    
    // 🔑 Tap into the store's `state` publisher.
    private var ordersStatePublisher: AnyPublisher<OrdersState, Never> {
        store.$state
            .map(\.ordersState)
            .eraseToAnyPublisher()
    }
    
    
    private var lastSavedOrderPubilsher: AnyPublisher<Order?, Never> {
        ordersStatePublisher
            .map(\.lastSavedOrder)
            .eraseToAnyPublisher()
    }
    
    
    private var saveErrorPubilsher: AnyPublisher<CupcakeAPIService.Error?, Never> {
        ordersStatePublisher
            .map(\.saveError)
            .eraseToAnyPublisher()
    }
    
    
    private var isShowingSaveConfirmationAlertPublisher: AnyPublisher<Bool, Never> {
        lastSavedOrderPubilsher
            .map( { $0 == nil ? false : true })
            .eraseToAnyPublisher()
    }
    
    
    private var isShowingSaveErrorAlertPublisher: AnyPublisher<Bool, Never> {
        saveErrorPubilsher
            .map( { $0 == nil ? false : true })
            .eraseToAnyPublisher()
    }
    
    
    private var saveConfirmationMessagePublisher: AnyPublisher<String, Never> {
        lastSavedOrderPubilsher
            .compactMap { $0 }
            .map { order in
                let cupcakesString = order.quantity == 1 ? "cupcake" : "cupcakes"
                
                return "Your order of \(order.quantity) \(cupcakesString) is on its way!"
            }
            .eraseToAnyPublisher()
    }
    
    
    private var saveErrorMessagePublisher: AnyPublisher<String, Never> {
        saveErrorPubilsher
            .compactMap { $0 }
            .map { "Please try again" } // This could obviously be improved, lol
            .eraseToAnyPublisher()
    }
}


// MARK: - Private Helpers
private extension OrderFormContainerViewModel {

    func setupSubscribers() {
        isShowingSaveConfirmationAlertPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.isShowingSaveConfirmationAlert, on: self)
            .store(in: &subscriptions)

        
        saveConfirmationMessagePublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.saveConfirmationMessage, on: self)
            .store(in: &subscriptions)
        
        
        isShowingSaveErrorAlertPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.isShowingSaveErrorAlert, on: self)
            .store(in: &subscriptions)

        
        saveErrorMessagePublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.saveErrorMessage, on: self)
            .store(in: &subscriptions)
    }
}
