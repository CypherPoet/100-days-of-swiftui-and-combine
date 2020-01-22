//
//  CardDeckContainerView+ViewModel.swift
//  Flashzilla
//
//  Created by CypherPoet on 1/19/20.
// ✌️
//


import SwiftUI
import Combine
import CoreData


extension CardDeckContainerView {
    
    final class ViewModel: ObservableObject {
        private var subscriptions = Set<AnyCancellable>()
        
        @ObservedObject var cardDeck: CardDeck

        var isTimerActive = false
        var roundDuration: TimeInterval
        
        
        // MARK: - Published Outputs
        @Published var cards: [Card] = []
        @Published var timeRemaining: TimeInterval
        
        
        // MARK: - Init
        init(
            cardDeck: CardDeck,
            roundDuration: TimeInterval = 100.0
        ) {
            self.cardDeck = cardDeck
            self.roundDuration = roundDuration
            self.timeRemaining = roundDuration

            setupSubscribers()
        }
    }
}

    
// MARK: - Publishers
extension CardDeckContainerView.ViewModel {
    
    private var roundTickPublisher: Publishers.Share<AnyPublisher<Date, Never>> {
        Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .eraseToAnyPublisher()
            .share()
    }
    
    
    private var timeRemainingPublisher: AnyPublisher<TimeInterval, Never> {
        roundTickPublisher
            .drop(while: { _ in !self.isTimerActive })
            .map { _ in
                self.isTimerActive ? max(0, self.timeRemaining - 1.0) : self.timeRemaining
            }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    
    private var cardsPublisher: Publishers.Share<AnyPublisher<[Card], Never>> {
        cardDeck.publisher(for: \.cards)
            .map { _ in self.cardDeck.cardsArray }
            .eraseToAnyPublisher()
            .share()
    }
}


// MARK: - Computeds
extension CardDeckContainerView.ViewModel {

    var visibleCards: [Card] {
        cards.filter { $0.answerState == .unanswered }
    }

    var isDeckEmpty: Bool { visibleCards.isEmpty }
}



// MARK: - Public Methods
extension CardDeckContainerView.ViewModel {
    
    func resetDeck() {
        cards.forEach { $0.answerState = .unanswered }
        
        self.isTimerActive = true
    }
    
    
    func pauseRound() {
        isTimerActive = false
    }
    
    func resumeRound() {
        isTimerActive = true
    }
    
    
    func record(_ answerState: Card.AnswerState, forCardAt index: Int) {
        let card = cards[index]
        
        guard let managedObjectContext = card.managedObjectContext else { fatalError() }
        
        card.answerState = answerState
        CurrentApp.coreDataManager.save(managedObjectContext)
        
        if isDeckEmpty {
           pauseRound()
        }
    }
}



// MARK: - Private Helpers
private extension CardDeckContainerView.ViewModel {

    func setupSubscribers() {
        cardsPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.cards, on: self)
            .store(in: &subscriptions)
        
        timeRemainingPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.timeRemaining, on: self)
            .store(in: &subscriptions)
        
        CurrentApp.notificationCenter
            .publisher(for: UIApplication.willResignActiveNotification)
            .map { _ in false }
            .assign(to: \.isTimerActive, on: self)
            .store(in: &subscriptions)

        CurrentApp.notificationCenter
            .publisher(for: UIApplication.willEnterForegroundNotification)
            .map { _ in self.isDeckEmpty == false }
            .assign(to: \.isTimerActive, on: self)
            .store(in: &subscriptions)
    }
}
