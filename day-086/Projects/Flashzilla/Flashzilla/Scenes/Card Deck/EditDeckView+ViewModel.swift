//
//  EditDeckView+ViewModel.swift
//  Flashzilla
//
//  Created by CypherPoet on 1/21/20.
// ✌️
//


import SwiftUI
import Combine
import CoreData


extension EditDeckView {
    final class ViewModel: ObservableObject {
        private var subscriptions = Set<AnyCancellable>()

        @ObservedObject var newCard: Card
        

        // MARK: - Published Outputs
        @Published var currentDeck: CardDeck
        @Published var canAddNewCard: Bool = false
        
        
        // MARK: - Init
        init(
            currentDeck: CardDeck,
            newCard: Card = Card(context: CurrentApp.coreDataManager.backgroundContext)
        ) {
            print("EditDeckView+ViewModel || init")
            self.currentDeck = currentDeck
            self.newCard = newCard
            
            setupSubscribers()
        }
    }
}


// MARK: - Publishers
extension EditDeckView.ViewModel {

    private var newCardPromptTextPublisher: Publishers.Share<AnyPublisher<String, Never>> {
        newCard.publisher(for: \.prompt)
            .debounce(for: .milliseconds(200), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .compactMap { $0 }
            .eraseToAnyPublisher()
            .share()
    }
    
    
    private var newCardAnswerTextPublisher: Publishers.Share<AnyPublisher<String, Never>> {
        newCard.publisher(for: \.answer)
            .debounce(for: .milliseconds(200), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .compactMap { $0 }
            .eraseToAnyPublisher()
            .share()
    }
    
    
    private var canAddNewCardPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(
            newCardPromptTextPublisher,
            newCardAnswerTextPublisher
        )
//        .print("canAddNewCardPublisher")
        .map { !$0.0.isEmpty && !$0.1.isEmpty }
        .eraseToAnyPublisher()
    }
}


// MARK: - Computeds
extension EditDeckView.ViewModel {
    var cards: [Card] { currentDeck.cardsArray }
}


// MARK: - Public Methods
extension EditDeckView.ViewModel {
    
    func addNewCard() {
        guard let managedObjectContext = currentDeck.managedObjectContext else { fatalError() }
        
        currentDeck.addToCards(newCard)
        CurrentApp.coreDataManager.save(managedObjectContext)
        
        newCard = makeNewCard()
    }
    
    
    func removeCards(at offsets: IndexSet) {
        guard let managedObjectContext = currentDeck.managedObjectContext else { fatalError() }

        for offset in offsets {
            currentDeck.removeFromCards(cards[offset])
        }

        CurrentApp.coreDataManager.save(managedObjectContext)
    }
}



// MARK: - Private Helpers
private extension EditDeckView.ViewModel {

    func makeNewCard() -> Card {
        Card(context: CurrentApp.coreDataManager.backgroundContext)
    }
    
    
    func setupSubscribers() {
        canAddNewCardPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.canAddNewCard, on: self)
            .store(in: &subscriptions)
    }
}
