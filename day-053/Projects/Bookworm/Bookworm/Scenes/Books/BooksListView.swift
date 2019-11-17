//
//  BooksListView.swift
//  Bookworm
//
//  Created by CypherPoet on 11/16/19.
// ✌️
//

import SwiftUI


struct BooksListView<Destination: View>: View {
    @ObservedObject private(set) var viewModel: BooksListViewModel
    
    let buildDestination: (Book) -> Destination
}


// MARK: - Body
extension BooksListView {

    var body: some View {
        List {
            Section(header: Text("\(viewModel.booksCount) Books")) {
                ForEach(viewModel.books, id: \.self) { book in
                    NavigationLink(destination: self.buildDestination(book)) {
                        BooksListRowItem(book: book)
                    }
                }
            }
        }
    }
}


// MARK: - Computeds
extension BooksListView {
}


// MARK: - View Variables
extension BooksListView {
}



// MARK: - Preview
struct BooksListView_Previews: PreviewProvider {

    static var previews: some View {
        BooksListView(
            viewModel: BooksListViewModel(books: SampleBooks.default),
            buildDestination: { _ in EmptyView() }
        )
    }
}
