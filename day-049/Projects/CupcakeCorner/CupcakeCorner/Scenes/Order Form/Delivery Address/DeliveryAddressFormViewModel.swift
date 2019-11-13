//
//  DeliveryAddressFormViewModel.swift
//  CupcakeCorner
//
//  Created by CypherPoet on 11/13/19.
// ✌️
//


import SwiftUI
import Combine


final class DeliveryAddressFormViewModel: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()


    // MARK: - Published Properties
    @Published var name: String = ""
    @Published var streetAddress: String = ""
    @Published var city: String = ""
    @Published var zipCode: String = ""
    
    @Published var isFormValid = false


    // MARK: - Init
    init() {
        setupSubscribers()
    }
}


// MARK: - Publishers
extension DeliveryAddressFormViewModel {

    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4($name, $streetAddress, $city, $zipCode)
            .map {
                $0.0.isEmpty == false &&
                $0.1.isEmpty == false &&
                $0.2.isEmpty == false &&
                $0.3.isEmpty == false
            }
            .eraseToAnyPublisher()
    }
}


// MARK: - Private Helpers
private extension DeliveryAddressFormViewModel {

    func setupSubscribers() {
        isFormValidPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.isFormValid, on: self)
            .store(in: &subscriptions)
    }
}
