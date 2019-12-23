//
//  BooksListViewModel.swift
//  Bookworm
//
//  Created by CypherPoet on 11/16/19.
// ✌️
//


import SwiftUI
import Combine


final class BooksListViewModel: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()

    var books: [Book]
    
    
    // MARK: - Published Properties


    // MARK: - Init
    init(books: [Book] = []) {
        self.books = books
    }
}


// MARK: - Publishers
extension BooksListViewModel {
}


// MARK: - Computeds
extension BooksListViewModel {
    var booksCount: Int { books.count }
}



// MARK: - Private Helpers
private extension BooksListViewModel {
}
