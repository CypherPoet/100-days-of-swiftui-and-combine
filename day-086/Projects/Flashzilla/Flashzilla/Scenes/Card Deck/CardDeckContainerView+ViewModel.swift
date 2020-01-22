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
import CypherPoetCoreDataKit


extension CardDeckContainerView {
    
    final class ViewModel: NSObject, ObservableObject, FetchedResultsControlling {
        typealias FetchedResult = Card
        
        lazy var fetchRequest: NSFetchRequest<Card> = Card.fetchRequest(forCardsIn: cardDeck)
        
        internal lazy var fetchedResultsController: FetchedResultsController = makeFetchedResultsController()

        private var subscriptions = Set<AnyCancellable>()
        

        @ObservedObject var cardDeck: CardDeck

        var isTimerActive = false
        var roundDuration: TimeInterval
        
        
        // MARK: - Published Outputs
        @Published var cards: [Card] = []
        @Published var visibleCards: [Card] = []
        @Published var timeRemaining: TimeInterval
        
        
        // MARK: - Init
        init(
            cardDeck: CardDeck,
            roundDuration: TimeInterval = 100.0
        ) {
            self.cardDeck = cardDeck
            self.roundDuration = roundDuration
            self.timeRemaining = roundDuration

            super.init()
            
            self.fetchedResultsController.delegate = self
            setupSubscribers()
            fetchCards()
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
    
    
    private var visibleCardsPublisher: AnyPublisher<[Card], Never> {
        $cards
            .map { $0.filter { $0.answerState == .unanswered } }
            .print("visibleCardsPublisher")
            .eraseToAnyPublisher()
    }
}


// MARK: - Computeds
extension CardDeckContainerView.ViewModel {
    var isDeckEmpty: Bool { visibleCards.isEmpty }
    var isTimeExpired: Bool { timeRemaining <= 0 }
    
    var correctAnswerCountText: String {
        let count = cardDeck.correctAnswerCount
        
        return "\(count) Correct \(count == 1 ? "Answer" : "Answers")"
    }
    
    
    var incorrectAnswerCountText: String {
        let count = cardDeck.incorrectAnswerCount
        
        return "\(count) Wrong \(count == 1 ? "Answer" : "Answers")"
    }
    
    
    var unansweredCountText: String {
        let count = cardDeck.unansweredCount
        
        return "\(count) \(count == 1 ? "Card" : "Cards") Unattempted"
    }
}



// MARK: - Public Methods
extension CardDeckContainerView.ViewModel {
    
    func fetchCards() {
        try? fetchedResultsController.performFetch()
        cards = extractResults(from: fetchedResultsController)
    }
    
    
    func resetDeck() {
        cards.forEach { $0.answerState = .unanswered }
        
        timeRemaining = roundDuration
        isTimerActive = true

        CurrentApp.coreDataManager.saveContexts()
    }
    
    
    func pauseRound() {
        isTimerActive = false
    }
    
    
    func resumeRound() {
        isTimerActive = true
    }
    
    
    func record(_ answerState: Card.AnswerState, forCardAt index: Int) {
        let card = visibleCards[index]
        
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
        visibleCardsPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.visibleCards, on: self)
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


// MARK: - NSFetchedResultsControllerDelegate
extension CardDeckContainerView.ViewModel: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let controller = controller as? FetchedResultsController else { return }
        
        print("controllerDidChangeContent")
        cards = extractResults(from: controller)
    }
}
