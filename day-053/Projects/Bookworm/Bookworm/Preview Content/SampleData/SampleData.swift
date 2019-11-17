//
//  SampleData.swift
//  Bookworm
//
//  Created by CypherPoet on 11/16/19.
// ✌️
//

#if DEBUG


import SwiftUI


enum SampleMOC {
    static let `default` = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}


enum SampleBooks {
    static let book1: Book = {
        var book = Book(context: SampleMOC.default)

        book.author = "Henry Hazlitt"
        book.title = "Economics in One Lesson"
        book.id = .init()
        book.genre = .economics
        book.rating = 5
        book.reviewText = "It was fantastic."

        return book
    }()


    static let book2: Book = {
        var book = Book(context: SampleMOC.default)
        
        book.author = "J. R. R. Tolkien"
        book.title = "The Silmarillion"
        book.id = .init()
        book.genre = .fantasy
        book.rating = 5
        book.reviewText = "Amazing."
        
        return book
    }()
    
    
    static let `default`: [Book] = [
        book1,
        book2
    ]
}


enum SampleBooksState {
    static let `default` = BooksState(allBooks: SampleBooks.default)
}


enum SampleAppState {
    static let `default` = AppState(
        booksState: SampleBooksState.default
    )
}


enum SampleStore {
    static let `default` = AppStore(initialState: SampleAppState.default, appReducer: appReducer)
}


#endif
