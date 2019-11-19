//
//  BooksListContainerView.swift
//  Bookworm
//
//  Created by CypherPoet on 11/16/19.
// ✌️
//

import SwiftUI


struct BooksListContainerView: View {
    @EnvironmentObject var store: AppStore
    @Environment(\.managedObjectContext) var moc

    @FetchRequest(entity: Book.entity(), sortDescriptors: Book.SortDescriptors.default) var books: FetchedResults<Book>
    
    @State private var isShowingAddScreen = false
}


// MARK: - Body
extension BooksListContainerView {

    var body: some View {
        NavigationView {
            BooksListView(
                books: Array(books),
                onBooksDeleted: deleteBooks(at:),
                buildDestination: {
                    BookDetailsView(book: $0, onDelete: self.delete(book:))
                }
            )
            .navigationBarTitle("Bookworm")
            .navigationBarItems(trailing: addBookButton)
            .sheet(isPresented: $isShowingAddScreen) {
                AddBookFormView(
                    onSubmit: self.submitNew(book:)
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
    
    private func submitNew(book: Book) {
        store.send(CoreDataSideEffect.save(managedObjectContext: moc))

        isShowingAddScreen = false
    }
    
    
    
    private func delete(book: Book) {
        moc.delete(book)

        // Uncomment to delete foeva
//        store.send(CoreDataSideEffect.save(managedObjectContext: moc))
    }
    
    
    private func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            
            moc.delete(book)
        }
        
        store.send(CoreDataSideEffect.save(managedObjectContext: moc))
    }
}



// MARK: - Preview
struct BooksListContainerView_Previews: PreviewProvider {

    static var previews: some View {
        BooksListContainerView()
            .environmentObject(SampleStore.default)
            .environment(\.managedObjectContext, SampleMOC.default)
    }
}
