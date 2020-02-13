//
//  DiceRollHistoryContainerView.swift
//  Dicey
//
//  Created by CypherPoet on 2/13/20.
// ✌️
//

import SwiftUI


struct DiceRollHistoryContainerView {
    @Environment(\.managedObjectContext) private var managedObjectContext
    @Environment(\.presentationMode) private var presentationMode
}


// MARK: - View
extension DiceRollHistoryContainerView: View {

    var body: some View {
        NavigationView {
            DiceRollHistoryListView()
                .navigationBarItems(trailing: doneButton)
                .navigationBarTitle(Text("Dice Rolls"), displayMode: .inline)
        }
    }
}


// MARK: - Computeds
extension DiceRollHistoryContainerView {
}


// MARK: - View Variables
extension DiceRollHistoryContainerView {

    private var doneButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("Done")
        }
    }
}


// MARK: - Private Helpers
private extension DiceRollHistoryContainerView {
}



// MARK: - Preview
struct DiceRollHistoryContainerView_Previews: PreviewProvider {

    static var previews: some View {
        DiceRollHistoryContainerView()
            .environment(\.managedObjectContext, CurrentApp.coreDataManager.mainContext)
    }
}
