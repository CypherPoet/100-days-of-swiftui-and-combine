//
//  AddExpenseViewModel.swift
//  Spendy
//
//  Created by CypherPoet on 10/31/19.
// ✌️
//

import SwiftUI
import Combine


final class AddExpenseViewModel: ObservableObject {
    private let textFieldDebounceTime: TimeInterval = 0.4
    private var subscriptions = Set<AnyCancellable>()
    
    
    // Form Inputs
    @Published var expenseName: String = ""
    @Published var amountText: String = ""
    @Published var satoshis: Double? = nil
    @Published var category: ExpenseItem.Category = .coffee
    
    
    @Published var isFormValid: Bool = false
    
    @Published var nameErrorMessage: String?
    @Published var satoshisErrorMessage: String?
    
    
    init() {
        setupSubscriptions()
    }
}


// MARK: - Computeds
extension AddExpenseViewModel {
    
    var newExpenseItem: ExpenseItem? {
        guard isFormValid else { return nil }
        
        return .init(name: expenseName, category: category, satoshis: satoshis!)
    }
}


// MARK: - Input  Publishers
extension AddExpenseViewModel {
    
    private var nameTextPublisher: AnyPublisher<String, Never> {
        $expenseName
            .debounce(for: .seconds(textFieldDebounceTime), scheduler: DispatchQueue.main)
            .print("Expense Name Value")
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    private var amountTextPublisher: AnyPublisher<String, Never> {
        $amountText
            .debounce(for: .seconds(textFieldDebounceTime), scheduler: DispatchQueue.main)
            .print("Satoshi Amount Value")
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    
    private var isNameEmptyPublisher: AnyPublisher<Bool, Never> {
        nameTextPublisher
            .dropFirst()
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    
    private var isAmountEmptyPublisher: AnyPublisher<Bool, Never> {
        amountTextPublisher
            .dropFirst()
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    
    private var isAmountPositivePublisher: AnyPublisher<Bool, Never> {
        amountNumberPublisher
            .print("isAmountPositivePublisher")
            .map { $0 != nil && $0! > 0 }
            .eraseToAnyPublisher()
    }
    
    
    private var amountNumberPublisher: AnyPublisher<Double?, Never> {
        Publishers.CombineLatest(isAmountEmptyPublisher, amountTextPublisher)
            .print("amountNumberPublisher")
            .drop(while: { (isEmpty, _) in isEmpty })
            .map { (_, textValue) in Double(textValue) }
            .eraseToAnyPublisher()
    }
    
    
    private var isAmountANumberPublisher: AnyPublisher<Bool, Never> {
        amountNumberPublisher
            .print("isAmountANumberPublisher")
            .map { $0 != nil }
            .eraseToAnyPublisher()
    }
}
    
 
// MARK: - Validations
extension AddExpenseViewModel {
    enum Validation {
        case empty
    }
    
    enum NameValidation {
        case empty
        case valid
    }
    
    enum SatoshiValidation {
        case empty
        case negative
        case notANumber
        case valid
    }

    
    private var nameValidationPublisher: AnyPublisher<NameValidation, Never> {
        isNameEmptyPublisher
            .map { isEmpty in
                isEmpty ? .empty : .valid
            }
            .eraseToAnyPublisher()
    }

    
    private var amountNumberValidationPublisher: AnyPublisher<SatoshiValidation, Never> {
        Publishers.CombineLatest(isAmountPositivePublisher, isAmountANumberPublisher)
            .print("amountNumberValidationPublisher")
            .map { (isPositive, isANumber) in
                if !isANumber { return .notANumber }
                if !isPositive { return .negative }
                
                return .valid
            }
        .eraseToAnyPublisher()
    }

    
    
    private var amountValidationPublisher: AnyPublisher<SatoshiValidation, Never> {
        Publishers.CombineLatest3(isAmountEmptyPublisher, isAmountPositivePublisher, isAmountANumberPublisher)
            .map { (isEmpty, isPositive, isANumber) in
                if isEmpty { return .empty }
                if !isANumber { return .notANumber }
                if !isPositive { return .negative }

                return .valid
            }
            .eraseToAnyPublisher()
        
    }
    
    
    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(amountValidationPublisher, nameValidationPublisher)
            .map { (amoutValidation, nameValidation) in
                amoutValidation == .valid && nameValidation == .valid
            }
            .eraseToAnyPublisher()
    }
}



// MARK: - Private Helpers
private extension AddExpenseViewModel {
    
    func setupSubscriptions() {
        amountNumberPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.satoshis, on: self)
            .store(in: &subscriptions)
        
        
        
        isFormValidPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.isFormValid, on: self)
            .store(in: &subscriptions)
        

        amountValidationPublisher
            .receive(on: DispatchQueue.main)
            .map { validation in
                switch validation {
                case .empty:
                    return "Value can not be empty."
                case .notANumber:
                    return "Value must be a number."
                case .negative:
                    return "Expenses must have a cost greater than 0."
                case .valid:
                    return nil
                }
            }
            .assign(to: \.satoshisErrorMessage, on: self)
            .store(in: &subscriptions)
        
        
        nameValidationPublisher
            .receive(on: DispatchQueue.main)
            .map { validation in
                switch validation {
                case .empty:
                    return "Value can not be empty"
                case .valid:
                    return nil
                }
            
            }
            .assign(to: \.nameErrorMessage, on: self)
            .store(in: &subscriptions)
    }
}
