//
//  BookDetailsViewModel.swift
//  Bookworm
//
//  Created by CypherPoet on 11/17/19.
// ✌️
//


import SwiftUI


struct BookDetailsViewModel {
    private(set) var book: Book
}



// MARK: - Computeds
extension BookDetailsViewModel {
    var navTitle: String { book.title ?? "Untitled" }
    var bookAuthorText: String { book.author ?? "Unknown Author" }
    var reviewText: String { book.reviewText ?? "" }
    
    var reivewDateText: String {
        guard let reviewDate = book.reviewDate else { return "" }
        let dateString = DateFormatters.bookDetailsReviewDate.string(from: reviewDate)
        
        return "Reviewed on \(dateString)."
    }
}


// MARK: - Public Methods
extension BookDetailsViewModel {
}



// MARK: - Private Helpers
private extension BookDetailsViewModel {
}
