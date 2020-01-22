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
        var currentDeck: CardDeck
        

        // MARK: - Published Outputs
        @Published var cards: [Card] = []
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

    private var cardsPublisher: Publishers.Share<AnyPublisher<[Card], Never>> {
        currentDeck.publisher(for: \.cards)
            .map { _ in self.currentDeck.cardsArray }
            .eraseToAnyPublisher()
            .share()
    }
    
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
}


// MARK: - Public Methods
extension EditDeckView.ViewModel {
    
    func addNewCard() {
        guard let managedObjectContext = newCard.managedObjectContext else { fatalError() }
        
        currentDeck.addToCards(newCard)
        CurrentApp.coreDataManager.save(managedObjectContext)
        
        newCard = makeNewCard()
    }
    
    
    func removeCards(at offsets: IndexSet) {
        for index in offsets {
            let card = cards[index]
            
            guard let managedObjectContext = card.managedObjectContext else { fatalError() }
            
            managedObjectContext.delete(card)
        }

        CurrentApp.coreDataManager.saveContexts()
    }
}



// MARK: - Private Helpers
private extension EditDeckView.ViewModel {

    func makeNewCard() -> Card {
        Card(context: CurrentApp.coreDataManager.backgroundContext)
    }
    
    
    func setupSubscribers() {
        cardsPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.cards, on: self)
            .store(in: &subscriptions)
        
        canAddNewCardPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.canAddNewCard, on: self)
            .store(in: &subscriptions)
    }
}
