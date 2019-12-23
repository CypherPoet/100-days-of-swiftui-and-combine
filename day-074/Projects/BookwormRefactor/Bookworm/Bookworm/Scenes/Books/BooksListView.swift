//
//  BooksListView.swift
//  Bookworm
//
//  Created by CypherPoet on 11/16/19.
// ✌️
//

import SwiftUI


struct BooksListView<Destination: View>: View {
    let buildDestination: (Book) -> Destination
    let onBooksDeleted: ((IndexSet) -> Void)
    
    @ObservedObject private(set) var viewModel: BooksListViewModel
    
    
    init(
        books: [Book],
        onBooksDeleted: @escaping ((IndexSet) -> Void),
        buildDestination: @escaping (Book) -> Destination
    ) {
        self.buildDestination = buildDestination
        self.onBooksDeleted = onBooksDeleted
        self.viewModel = BooksListViewModel(books: Array(books))
    }
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
                .onDelete(perform: onBooksDeleted)
            }
        }
        .navigationBarItems(leading: EditButton())
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
        NavigationView {
            BooksListView(
                books: SampleBooks.default,
                onBooksDeleted: { _ in },
                buildDestination: { _ in EmptyView() }
            )
        }
    }
}
