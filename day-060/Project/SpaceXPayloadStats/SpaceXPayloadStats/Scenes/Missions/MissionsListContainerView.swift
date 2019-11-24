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
            missions: store.state.missionsState.missions,
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
            buildDestination: buildDestination(forPayloadID:)
        )
    }
    
    
    func buildDestination(forPayloadID payloadID: Payload.ID) -> some View {
        PayloadDetailsView(
            payloadID: payloadID,
            store: store
        )
    }
}




// MARK: - Preview
struct MissionsListContainerView_Previews: PreviewProvider {

    static var previews: some View {
        MissionsListContainerView()
            .environmentObject(SampleStore.noModels)
    }
}
