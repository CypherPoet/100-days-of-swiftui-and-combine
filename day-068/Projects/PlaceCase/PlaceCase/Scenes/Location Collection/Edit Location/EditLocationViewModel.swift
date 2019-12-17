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

    var store: AppStore! {
        didSet {
            guard store != nil else { return }
            self.setupSubscribers()
        }
    }
    
    @ObservedObject var location: Location
    
    
    init(location: Location) {
        self.location = location
    }


    // MARK: - Published Outputs
    @Published var wikiPagesFetchState: WikiPagesState.FetchState = .inactive
}


// MARK: - Publishers
extension EditLocationViewModel {

    private var wikiPagesFetchStatePublisher: AnyPublisher<WikiPagesState.FetchState, Never> {
        store.$state
            .map(\.wikiPagesState.currentFetchState)
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
