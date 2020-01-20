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
        
        
        lazy var fetchRequest: NSFetchRequest<Card> = {
            let request: NSFetchRequest<Card> = Card.fetchRequest()
            
            request.sortDescriptors = []
            
            return request
        }()
        
        
        lazy var fetchedResultsController: FetchedResultsController = makeFetchedResultsController()
        

        // MARK: - Published Outputs
        @Published var cards: [Card] = []

        
        // MARK: - Init
        override init() {
            super.init()
            
            setupSubscribers()
            
            self.fetchedResultsController.delegate = self
            fetchCards()
        }
    }
}

    
// MARK: - Publishers
extension CardDeckContainerView.ViewModel {

    private var someValuePublisher: AnyPublisher<String, Never> {
        Just("")
            .eraseToAnyPublisher()
    }
}


// MARK: - Computeds
extension CardDeckContainerView.ViewModel {
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
//        someValuePublisher
//            .receive(on: DispatchQueue.main)
//            .assign(to: \.someValue, on: self)
//            .store(in: &subscriptions)
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
