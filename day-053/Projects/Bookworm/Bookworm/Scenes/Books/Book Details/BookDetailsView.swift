//
//  BookDetailsView.swift
//  Bookworm
//
//  Created by CypherPoet on 11/17/19.
// ✌️
//

import SwiftUI


struct BookDetailsView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode

    let onDelete: ((Book) -> Void)
    
    private(set) var viewModel: BookDetailsViewModel
    @State private var isShowingDeleteAlert = false
    
    
    init(book: Book, onDelete: @escaping ((Book) -> Void)) {
        self.onDelete = onDelete
        self.viewModel = BookDetailsViewModel(book: book)
    }
}


// MARK: - Body
extension BookDetailsView {

    var body: some View {
        GeometryReader { geometry in
            VStack {
                GenreBanner(genre: self.viewModel.book.genre, container: geometry)
                
                HStack {
                    Image(systemName: "person.fill")
                    Text(self.viewModel.bookAuthorText)
                        .font(.title)
                        .foregroundColor(.secondary)
                }
                
                                
                Text(self.viewModel.reviewText)
                    .padding()
                                
                StarRatingView(rating: .constant(Int(self.viewModel.book.rating)))
                    .font(.largeTitle)
                                
                Spacer()
            }
        }
        .navigationBarTitle(Text(viewModel.navTitle), displayMode: .inline)
        .navigationBarItems(trailing: deleteButton)
        .alert(isPresented: $isShowingDeleteAlert, content: { self.deleteAlert })
    }
}


// MARK: - Computeds
extension BookDetailsView {
    
    var deleteAlert: Alert {
        Alert(
            title: Text("Are you sure?"),
            message: Text("This book will be permantly deleted from your collection."),
            primaryButton: .destructive(Text("Delete")) {
                self.onDelete(self.viewModel.book)
                
                self.presentationMode.wrappedValue.dismiss()
            },
            secondaryButton: .cancel()
        )
    }

}


// MARK: - View Variables
extension BookDetailsView {

    private var deleteButton: some View {
        Button(action: {
            self.isShowingDeleteAlert = true
        }) {
            Image(systemName: "trash")
                .imageScale(.large)
        }
    }
}



// MARK: - Preview
struct BookDetailsView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            BookDetailsView(
                book: SampleBooks.book1,
                onDelete: { _ in }
            )
            .environment(\.managedObjectContext, SampleMOC.default)
        }
    }
}

