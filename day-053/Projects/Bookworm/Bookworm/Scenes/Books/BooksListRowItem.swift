//
//  BooksListRowItem.swift
//  Bookworm
//
//  Created by CypherPoet on 11/17/19.
// ✌️
//

import SwiftUI


struct BooksListRowItem: View {
    let book: Book
}


// MARK: - Body
extension BooksListRowItem {
    
    var body: some View {
        HStack {
            Text(book.emojiForRating)
                .font(.title)
            
            VStack(alignment: .leading) {
                Text(book.title ?? "Unknown Title")
                    .font(.headline)
                
                Text(book.author ?? "Unknown Author")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}


// MARK: - Computeds
extension BooksListRowItem {
}


// MARK: - View Variables
extension BooksListRowItem {
}



// MARK: - Preview
struct BooksListRowItem_Previews: PreviewProvider {

    static var previews: some View {
        BooksListRowItem(book: SampleBooks.book1)
    }
}
