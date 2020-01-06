//
//  EditLocationViewModel.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/16/19.
// ✌️
//


import SwiftUI
import Combine


final class EditLocationViewModel: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()

    @ObservedObject var location: Location
    private let wikiPagesState: WikiPagesState
    
    
    // MARK: - Published Outputs
    @Published var wikiPagesFetchState: WikiPagesState.FetchState = .inactive
    
    
    // MARK: - Init
    init(
        location: Location,
        wikiPagesState: WikiPagesState
    ) {
        self.location = location
        self.wikiPagesState = wikiPagesState
        
        setupSubscribers()
    }
}


// MARK: - Publishers
extension EditLocationViewModel {

    private var wikiPagesFetchStatePublisher: AnyPublisher<WikiPagesState.FetchState, Never> {
        CurrentValueSubject(wikiPagesState.currentFetchState)
            .eraseToAnyPublisher()
    }
}


// MARK: - Computeds
extension EditLocationViewModel {
    var wikiPages: [WikiPage] { location.wikiPagesArray }
}


// MARK: - Public Methods
extension EditLocationViewModel {
}



// MARK: - Private Helpers
private extension EditLocationViewModel {

    func setupSubscribers() {
        wikiPagesFetchStatePublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.wikiPagesFetchState, on: self)
            .store(in: &subscriptions)
    }
}
