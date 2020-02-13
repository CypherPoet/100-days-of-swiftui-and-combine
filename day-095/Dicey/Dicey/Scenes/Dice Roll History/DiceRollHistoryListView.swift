//
//  DiceRollHistoryListView.swift
//  Dicey
//
//  Created by CypherPoet on 2/13/20.
// ✌️
//

import SwiftUI


struct DiceRollHistoryListView {
    @Environment(\.managedObjectContext) private var managedObjectContext

    @FetchRequest(
        fetchRequest: DiceRoll.FetchRequests.default, animation: nil
    ) private var diceRolls: FetchedResults<DiceRoll>
}


// MARK: - View
extension DiceRollHistoryListView: View {

    var body: some View {
        List(diceRolls) { diceRoll in
            VStack {
                DiceRollListItemSummaryView(diceRoll: diceRoll)
                    .frame(height: 40)
                
                Text(diceRoll.listFormattedDateString)
                    .multilineTextAlignment(.leading)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
        }
    }
}


// MARK: - Computeds
extension DiceRollHistoryListView {
}


// MARK: - View Variables
extension DiceRollHistoryListView {
}


// MARK: - Private Helpers
private extension DiceRollHistoryListView {
}



// MARK: - Preview
struct DiceRollHistoryListView_Previews: PreviewProvider {

    static var previews: some View {
        PreviewData.setupSimulatorPreviewData(in: CurrentApp.coreDataManager.mainContext)

        return DiceRollHistoryListView()
            .environment(\.managedObjectContext, CurrentApp.coreDataManager.mainContext)
    }
}
