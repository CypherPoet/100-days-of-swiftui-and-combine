//
//  BooksListContainerView.swift
//  Bookworm
//
//  Created by CypherPoet on 11/16/19.
// ✌️
//

import SwiftUI


struct BooksListContainerView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>

    @EnvironmentObject var store: AppStore
    
    @State private var isShowingAddScreen = false
}


// MARK: - Body
extension BooksListContainerView {

    var body: some View {
        NavigationView {
            BooksListView(
                viewModel: BooksListViewModel(books: Array(books)),
                buildDestination: { book in
                    // TODO: Create a book detail view
                    EmptyView()
                }
            )
            .navigationBarTitle("Bookworm")
            .navigationBarItems(trailing: addBookButton)
            .sheet(isPresented: $isShowingAddScreen) {
                AddBookFormView(
                    viewModel: AddBookFormViewModel(),
                    onSubmit: self.newBookSubmitted(_:)
                )
                .environment(\.managedObjectContext, self.moc)
            }
        }
    }
}


// MARK: - Computeds
extension BooksListContainerView {
}


// MARK: - View Variables
extension BooksListContainerView {

    private var addBookButton: some View {
        Button(action: {
            self.isShowingAddScreen = true
        }) {
            Image(systemName: "plus")
                .imageScale(.large)
        }
    }
}


// MARK: - Private Helpers
extension BooksListContainerView {
    
    private func newBookSubmitted(_ book: Book) {
        isShowingAddScreen = false

        try? moc.save()
//        store.send(BookSideEffect.)
    }
}



// MARK: - Preview
struct BooksListContainerView_Previews: PreviewProvider {

    static var previews: some View {
        BooksListContainerView()
            .environment(\.managedObjectContext, SampleMOC.default)
            .environmentObject(SampleStore.default)
    }
}
