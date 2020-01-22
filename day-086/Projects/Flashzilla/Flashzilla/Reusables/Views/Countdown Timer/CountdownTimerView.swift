//
//  CountdownTimerView.swift
//  Flashzilla
//
//  Created by CypherPoet on 1/21/20.
// ✌️
//

import SwiftUI


struct CountdownTimerView {
    var viewModel: ViewModel
}


// MARK: - View
extension CountdownTimerView: View {
    var body: some View {
        Text("Time Remaining: ")
            .font(.title)
            .foregroundColor(Color("Accent3"))

        + Text(self.viewModel.timeRemainingText)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(Color("Accent3"))
    }
}


// MARK: - Preview
struct CountdownTimerView_Previews: PreviewProvider {

    static var previews: some View {
        CountdownTimerView(
            viewModel: .init()
        )
        .environment(\.managedObjectContext, CurrentApp.coreDataManager.mainContext)
    }
}
