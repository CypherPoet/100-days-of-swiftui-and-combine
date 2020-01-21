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
    
    final class ViewModel: NSObject, FetchedResultsControlling, ObservableObject {
        typealias FetchedResult = Card
        private var subscriptions = Set<AnyCancellable>()
        
        
        internal lazy var fetchRequest: NSFetchRequest<Card> = {
            let request: NSFetchRequest<Card> = Card.fetchRequest()
            
            request.sortDescriptors = []
            
            return request
        }()
        
        
        internal lazy var fetchedResultsController: FetchedResultsController = makeFetchedResultsController()
        
        
        var isTimerActive = true
        var roundDuration: TimeInterval
        
        
        // MARK: - Published Outputs
        @Published var cards: [Card] = []
        @Published var timeRemaining: TimeInterval
        
        
        // MARK: - Init
        init(
            roundDuration: TimeInterval = 100.0
        ) {
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
            .map { _ in
                self.isTimerActive ? max(0, self.timeRemaining - 1.0) : self.timeRemaining
            }
            .removeDuplicates()
            .eraseToAnyPublisher()
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
    
    func fetchCards() {
        try? fetchedResultsController.performFetch()
        cards = extractResults(from: fetchedResultsController)
    }
    
    
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
}



// MARK: - Private Helpers
private extension CardDeckContainerView.ViewModel {

    func setupSubscribers() {
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
