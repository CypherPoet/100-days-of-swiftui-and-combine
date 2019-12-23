//
//  BookDetailsView.swift
//  Bookworm
//
//  Created by CypherPoet on 11/17/19.
// ✌️
//

import SwiftUI


struct BookDetailsView: View {
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
                
                VStack(spacing: 28.0) {
                    self.authorSection
                    self.reviewHeaderSection
                    self.reviewBodySection
                        .padding(.horizontal)
                }
                
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
    
    
    private var authorSection: some View {
        HStack {
            
            Image(systemName: "person.fill")
            
            Text(viewModel.bookAuthorText)
                .fontWeight(.light)
        }
        .font(.title)
    }
    
    
    private var reviewHeaderSection: some View {
        VStack(spacing: 8) {
            StarRatingView(rating: .constant(Int(viewModel.book.rating)))
                .font(.title)

            Text(viewModel.reivewDateText)
                .font(.callout)
                .foregroundColor(.secondary)
        }
    }
    
    
    private var reviewBodySection: some View {
        HStack {
            Text(viewModel.reviewText)
            Spacer()
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
        }
    }
}

