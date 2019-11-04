//
//  MissionsListView.swift
//  Moonshot
//
//  Created by CypherPoet on 11/2/19.
// ✌️
//

import SwiftUI


struct MissionsListView: View {
    @EnvironmentObject var store: AppStore
    
    @State private var itemDisplayMode: MissionsListItemRow.DisplayMode = .launchDate
}


// MARK: - Computeds
extension MissionsListView {
    var missions: [Mission] { store.state.missionsState.missions }
    
    var itemDisplayModeButtonTitle: String {
        switch itemDisplayMode {
        case .crew:
            return "Show Launch Dates"
        case .launchDate:
            // 📝 The extra left padding is a hack to prevent the text from
            // drifting leftwards after the longer "Show Launch Dates" text
            // is rendered, and then toggled back to "Show Crew" again.
            // Would love to know of a cleaner solution here 🙂.
            return "           Show Crew"
        }
    }
}


// MARK: - Body
extension MissionsListView {

    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionDetailsContainerView(mission: mission)) {
                    MissionsListItemRow(mission: mission, displayMode: self.itemDisplayMode)
                }
            }
            .navigationBarTitle("Missions")
            .navigationBarItems(trailing: displayModeButton)
        }
    }
}


// MARK: - View Variables
extension MissionsListView {

    var displayModeButton: some View {
        Button(action: {
            self.itemDisplayMode = self.itemDisplayMode == .launchDate ? .crew : .launchDate
        }, label: {
            Text(self.itemDisplayModeButtonTitle)
        })
    }
}



// MARK: - Preview
struct MissionsListView_Previews: PreviewProvider {

    static var previews: some View {
        let store = SampleStore.default
        
        return MissionsListView()
            .environmentObject(store)
            .accentColor(.purple)
            .onAppear {
                store.send(MissionSideEffect.loadMissions)
            }
    }
}
