//
//  AddBookFormViewModel.swift
//  Bookworm
//
//  Created by CypherPoet on 11/16/19.
// ✌️
//


import SwiftUI
import Combine


final class AddBookFormViewModel: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Form Inputs
    @Published var title: String = ""
    @Published var author: String = ""
    @Published var genre: Book.Genre = .misc
    @Published var reviewText: String = ""

    @Published var rating: Int = 0
    
    let ratingRange: ClosedRange<Int> = ClosedRange(uncheckedBounds: (lower: 0, upper: 5))
    

    // MARK: - Init
    init() {
        setupSubscribers()
    }
}


// MARK: - Publishers
extension AddBookFormViewModel {

    private var someValuePublisher: AnyPublisher<String, Never> {
        Just("")
            .eraseToAnyPublisher()
    }
}


// MARK: - Computeds
extension AddBookFormViewModel {
}


// MARK: - Public Methods
extension AddBookFormViewModel {
}



// MARK: - Private Helpers
private extension AddBookFormViewModel {

    func setupSubscribers() {
    }
}
