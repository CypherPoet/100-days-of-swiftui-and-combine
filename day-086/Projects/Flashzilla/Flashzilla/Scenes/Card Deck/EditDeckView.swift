//
//  EditDeckView.swift
//  Flashzilla
//
//  Created by CypherPoet on 1/21/20.
// ✌️
//

import SwiftUI
import CypherPoetCoreDataKit_BindingUtils


struct EditDeckView {
    @Environment(\.presentationMode) private var presentationMode

    @ObservedObject var viewModel: ViewModel
}


// MARK: - View
extension EditDeckView: View {
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("New Card").font(.headline)) {
                    TextField("Prompt", text: Binding($viewModel.newCard.prompt, replacingNilWith: ""))
                    TextField("Answer", text: Binding($viewModel.newCard.answer, replacingNilWith: ""))

                    Button(action: viewModel.addNewCard) {
                        Text("Add New Card")
                    }
                    .disabled(!viewModel.canAddNewCard)
                    .foregroundColor(.accentColor)
                }
                
                
                Section(header: Text("Current Cards")) {
                    ForEach(viewModel.currentDeck) { card in
                        VStack(alignment: .leading) {
                            Text(card.prompt ?? "")
                                .font(.headline)
                            
                            Text(card.answer ?? "")
                                .font(.subheadline)
                        }
                    }
                    .onDelete(perform: viewModel.removeCards(at:))
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Edit Cards")
            .navigationBarItems(trailing: doneButton)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


// MARK: - Computeds
extension EditDeckView {
}


// MARK: - View Variables
extension EditDeckView {
    
    private var doneButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("Done")
        }
    }
}


// MARK: - Private Helpers
private extension EditDeckView {
}



// MARK: - Preview
struct EditDeckView_Previews: PreviewProvider {
    static var previews: some View {
        
        EditDeckView(
            viewModel: .init(
                currentDeck: [PreviewData.Cards.card1, PreviewData.Cards.card2]
            )
        )
        .environment(\.managedObjectContext, CurrentApp.coreDataManager.mainContext)
    }
}
