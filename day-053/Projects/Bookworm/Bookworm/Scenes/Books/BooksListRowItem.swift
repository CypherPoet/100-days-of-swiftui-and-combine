//
//  BooksListRowItem.swift
//  Bookworm
//
//  Created by CypherPoet on 11/17/19.
// ✌️
//

import SwiftUI
import CypherPoetSwiftUIKit


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
                bookTitle
                
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
    
    private var bookTitle: some View {
        let text = Text(book.title ?? "Unknown Title")
            .font(.headline)
        
        return Group {
            if book.rating < 2 {
                text.foregroundColor(.red)
            } else {
                text
            }
        }
    }
}



// MARK: - Preview
struct BooksListRowItem_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            BooksListRowItem(book: SampleBooks.book1)
            BooksListRowItem(book: SampleBooks.oneStar)
        }
    }
}
