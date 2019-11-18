//
//  PricesState.swift
//  Bookworm
//
//  Created by CypherPoet on 11/9/19.
// ✌️
//

import Foundation
import Combine
import CypherPoetSwiftUIKit
import CoreData


struct BooksState {
    var allBooks: [Book] = []
}


//enum BookSideEffect: SideEffect {
//    case addNew(book: Book, in: NSManagedObjectContext)
//
//    func mapToAction() -> AnyPublisher<AppAction, Never> {
//        switch self {
//        case let .addNew(book, managedObjectContext):
//            Just(book)
//                .compactMap { _ in try? managedObjectContext.save() }
//                .eraseToAnyPublisher()
//        }
//    }
//}



enum BooksAction {
    case set(books: [Book])
}



// MARK: - Reducer
let booksReducer = Reducer<BooksState, BooksAction> { state, action in
    switch action {
    case let .set(books):
        state.allBooks = books
    }
}
