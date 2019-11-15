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
    private let textFieldDebounceTime: TimeInterval = 0.3
    private var subscriptions = Set<AnyCancellable>()


    // MARK: - Form Inputs
    @Published var nameText: String = ""
    @Published var streetAddressText: String = ""
    @Published var cityText: String = ""
    @Published var zipCodeText: String = ""
    
    
    // MARK: - Form Inputs
    @Published var nameErrorMessage: String?
    @Published var streetAddressErrorMessage: String?
    @Published var cityErrorMessage: String?
    @Published var zipCodeErrorMessage: String?
    @Published var isFormValid = false


    // MARK: - Init
    init() {
        setupSubscribers()
    }
}


// MARK: - Base publisers for text fields
extension DeliveryAddressFormViewModel {

    private var nameTextPublisher: AnyPublisher<String, Never> {
        $nameText
            .debounce(for: .seconds(textFieldDebounceTime), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    private var streetAddressTextPublisher: AnyPublisher<String, Never> {
        $streetAddressText
            .debounce(for: .seconds(textFieldDebounceTime), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    private var cityTextPublisher: AnyPublisher<String, Never> {
        $cityText
            .debounce(for: .seconds(textFieldDebounceTime), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    private var zipCodeTextPublisher: AnyPublisher<String, Never> {
        $zipCodeText
            .debounce(for: .seconds(textFieldDebounceTime), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
}

// MARK: - Emptiness Checking
extension DeliveryAddressFormViewModel {
    
    private var isNameEmptyPublisher: AnyPublisher<Bool, Never> {
        nameTextPublisher
            .dropFirst()
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .map(\.isEmpty)
            .eraseToAnyPublisher()
    }
    
    private var isStreetAddressEmptyPublisher: AnyPublisher<Bool, Never> {
        streetAddressTextPublisher
            .dropFirst()
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .map(\.isEmpty)
            .eraseToAnyPublisher()
    }
    
    private var isCityEmptyPublisher: AnyPublisher<Bool, Never> {
        cityTextPublisher
            .dropFirst()
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .map(\.isEmpty)
            .eraseToAnyPublisher()
    }
    
    private var isZipCodeEmptyPublisher: AnyPublisher<Bool, Never> {
        zipCodeTextPublisher
            .dropFirst()
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .map(\.isEmpty)
            .eraseToAnyPublisher()
    }
}


// MARK: -Validations
extension DeliveryAddressFormViewModel {
    enum Validation {
        case isEmpty
        case valid
    }
    
    private var nameValidationPublisher: AnyPublisher<Validation, Never> {
        isNameEmptyPublisher
            .map { $0 == true ? .isEmpty : .valid }
            .eraseToAnyPublisher()
    }
    
    private var streetAddressValidationPublisher: AnyPublisher<Validation, Never> {
        isStreetAddressEmptyPublisher
            .map { $0 == true ? .isEmpty : .valid }
            .eraseToAnyPublisher()
    }
    
    private var cityValidationPublisher: AnyPublisher<Validation, Never> {
        isCityEmptyPublisher
            .map { $0 == true ? .isEmpty : .valid }
            .eraseToAnyPublisher()
    }
    
    private var zipCodeValidationPublisher: AnyPublisher<Validation, Never> {
        isZipCodeEmptyPublisher
            .map { $0 == true ? .isEmpty : .valid }
            .eraseToAnyPublisher()
    }
}


// MARK: - Error Messages
extension DeliveryAddressFormViewModel {
    private var nameErrorMessagePublisher: AnyPublisher<String?, Never> {
        nameValidationPublisher
            .map { validation in
                switch validation {
                case .isEmpty:
                    return "Field cannot be empty"
                case .valid:
                    return nil
                }
            }
            .eraseToAnyPublisher()
    }
    
    private var streetAddressErrorMessagePublisher: AnyPublisher<String?, Never> {
        streetAddressValidationPublisher
            .map { validation in
                switch validation {
                case .isEmpty:
                    return "Field cannot be empty"
                case .valid:
                    return nil
                }
            }
            .eraseToAnyPublisher()
    }
    
    private var cityErrorMessagePublisher: AnyPublisher<String?, Never> {
        cityValidationPublisher
            .map { validation in
                switch validation {
                case .isEmpty:
                    return "Field cannot be empty"
                case .valid:
                    return nil
                }
            }
            .eraseToAnyPublisher()
    }
    
    private var zipCodeErrorMessagePublisher: AnyPublisher<String?, Never> {
        zipCodeValidationPublisher
            .map { validation in
                switch validation {
                case .isEmpty:
                    return "Field cannot be empty"
                case .valid:
                    return nil
                }
            }
            .eraseToAnyPublisher()
    }
}


// MARK: - Is Form Valid?
extension DeliveryAddressFormViewModel {
    
    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4(
            nameValidationPublisher,
            streetAddressValidationPublisher,
            cityValidationPublisher,
            zipCodeValidationPublisher
        )
            .map {
                $0.0 == .valid &&
                $0.1 == .valid &&
                $0.2 == .valid &&
                $0.3 == .valid
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
        
        
        nameErrorMessagePublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.nameErrorMessage, on: self)
            .store(in: &subscriptions)
        
        
        streetAddressErrorMessagePublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.streetAddressErrorMessage, on: self)
            .store(in: &subscriptions)
        
        
        cityErrorMessagePublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.cityErrorMessage, on: self)
            .store(in: &subscriptions)
        
        
        zipCodeErrorMessagePublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.zipCodeErrorMessage, on: self)
            .store(in: &subscriptions)
    }
}
