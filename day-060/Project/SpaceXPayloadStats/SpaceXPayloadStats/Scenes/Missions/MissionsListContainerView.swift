//
//  MissionsListContainerView.swift
//  SpaceXPayloadStats
//
//  Created by CypherPoet on 11/23/19.
// ✌️
//

import SwiftUI


struct MissionsListContainerView: View {
    @EnvironmentObject private(set) var store: AppStore
}



// MARK: - Body
extension MissionsListContainerView {

    var body: some View {
        NavigationView {
            missionsList
        }
        .onAppear(perform: fetchMissions)
    }
}


// MARK: - Computeds
extension MissionsListContainerView {
}


// MARK: - View Variables
extension MissionsListContainerView {

    private var missionsList: some View {
        MissionsListView(
            buildDestination: buildDestination(forMission:)
        )
    }
}


// MARK: - Private Helpers
private extension MissionsListContainerView {
    
    func fetchMissions() {
        store.send(MissionsSideEffect.fetch)
    }
    
    
    func buildDestination(forMission mission: Mission) -> some View {
        MissionDetailsView(
            mission: mission,
            buildDestination: buildDestination(forPayload:)
        )
    }
    
    
    func buildDestination(forPayload payload: Payload) -> some View {
        PayloadDetailsView(payload: payload)
    }
}




// MARK: - Preview
struct MissionsListContainerView_Previews: PreviewProvider {

    static var previews: some View {
        MissionsListContainerView()
            .environment(\.managedObjectContext, SampleMOC.mainContext)
            .environmentObject(SampleStore.default)
    }
}
