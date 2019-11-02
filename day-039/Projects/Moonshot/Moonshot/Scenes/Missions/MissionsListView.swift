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
}


// MARK: - Computeds
extension MissionsListView {
    var missions: [Mission] { store.state.missionState.missions }
}


// MARK: - Body
extension MissionsListView {

    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: Text("Detail View")) {
                    Image(mission.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading) {
                        Text("\(mission.displayName)")
                            .font(.headline)
                        
                        Text("Launch Date: \(mission.formattedLaunchDate)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationBarTitle("Missions")
        }
    }
}


// MARK: - View Variables
extension MissionsListView {


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
