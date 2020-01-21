//
//  CardView+ViewModel.swift
//  Flashzilla
//
//  Created by CypherPoet on 1/19/20.
// ✌️
//


import SwiftUI
import Combine


extension CardView {
    final class ViewModel: ObservableObject {
        private var subscriptions = Set<AnyCancellable>()

        @ObservedObject private var card: Card
        
        
        // MARK: - Published Outputs
        @Published var cardPromptText: String = ""
        @Published var cardAnswerText: String = ""

        
        // MARK: - Init
        init(card: Card) {
            self.card = card
            
            setupSubscribers()
        }
    }
}


// MARK: - Publishers
extension CardView.ViewModel {

    private var cardPromptTextPublisher: AnyPublisher<String, Never> {
        card.publisher(for: \.prompt)
            .compactMap( { $0 })
            .eraseToAnyPublisher()
    }
    
    
    private var cardAnswerTextPublisher: AnyPublisher<String, Never> {
        card.publisher(for: \.answer)
            .compactMap( { $0 })
            .eraseToAnyPublisher()
    }
}


// MARK: - Computeds
extension CardView.ViewModel {
}


// MARK: - Public Methods
extension CardView.ViewModel {
}



// MARK: - Private Helpers
private extension CardView.ViewModel {

    func setupSubscribers() {
        cardPromptTextPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.cardPromptText, on: self)
            .store(in: &subscriptions)
        
        
        cardAnswerTextPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.cardAnswerText, on: self)
            .store(in: &subscriptions)
    }
}
