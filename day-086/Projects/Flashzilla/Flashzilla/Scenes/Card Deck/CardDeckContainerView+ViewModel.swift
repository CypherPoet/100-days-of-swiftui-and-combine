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
        private var isTimerActive = true
        
        
        internal lazy var fetchRequest: NSFetchRequest<Card> = {
            let request: NSFetchRequest<Card> = Card.fetchRequest()
            
            request.sortDescriptors = []
            
            return request
        }()
        
        
        internal lazy var fetchedResultsController: FetchedResultsController = makeFetchedResultsController()
        
        
        var roundDuration: TimeInterval
        
        
        // MARK: - Published Outputs
        @Published var cards: [Card] = []
        @Published var timeRemaining: TimeInterval
        
        // MARK: - Init
        init(
            roundDuration: TimeInterval = 10.0
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
            .eraseToAnyPublisher()
    }
}


// MARK: - Computeds
extension CardDeckContainerView.ViewModel {
    
    var timeRemainingText: String {
        NumberFormatters.cardCountdown.string(for: timeRemaining) ?? ""
    }
}



// MARK: - Public Methods
extension CardDeckContainerView.ViewModel {
    
    func fetchCards() {
        try? fetchedResultsController.performFetch()
        cards = extractResults(from: fetchedResultsController)
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
            .map { _ in true }
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
