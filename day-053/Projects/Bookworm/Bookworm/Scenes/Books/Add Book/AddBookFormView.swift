//
//  AddBookFormView.swift
//  Bookworm
//
//  Created by CypherPoet on 11/16/19.
// ✌️
//

import SwiftUI


struct AddBookFormView: View {
    @ObservedObject private(set) var viewModel: AddBookFormViewModel
    @Environment(\.managedObjectContext) var moc

    var onSubmit: ((Book) -> Void)
}


// MARK: - Body
extension AddBookFormView {

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title of the Book", text: $viewModel.title)
                    TextField("Author", text: $viewModel.author)

                    Picker("Genre", selection: $viewModel.genre) {
                        ForEach(Book.Genre.allCases) { genre in
                            Text(genre.displayValue).tag(genre)
                        }
                    }
                }

                
                Section(
                    header: Text("Rating")
                        .font(.headline)
                ) {
                    StarRatingView(
                        rating: $viewModel.rating,
                        onColor: .purple
                    )
                    

                    TextField("Write a review", text: $viewModel.reviewText)
                }
            }
            .navigationBarTitle("Add A Book")
            .navigationBarItems(trailing: submitButton)
        }
    }
}


// MARK: - Computeds
extension AddBookFormView {
    
    var bookFromFormData: Book {
        let book = Book(context: moc)

        book.title = viewModel.title
        book.author = viewModel.author
        book.genre = viewModel.genre
        book.reviewText = viewModel.reviewText
        book.rating = Int16(viewModel.rating)
        
        return book
    }
}


// MARK: - View Variables
extension AddBookFormView {
    
    private var submitButton: some View {
        Button(action: {
            self.onSubmit(self.bookFromFormData)
        }) {
            Text("Save")
        }
    }
}



// MARK: - Preview
struct AddBookFormView_Previews: PreviewProvider {

    static var previews: some View {
        
        AddBookFormView(
            viewModel: AddBookFormViewModel(),
            onSubmit: { _ in }
        )
        .environment(\.managedObjectContext, SampleMOC.default)
    }
}
