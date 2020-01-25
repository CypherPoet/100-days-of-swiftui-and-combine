//
//  MissionDetailsContainerView.swift
//  Moonshot
//
//  Created by CypherPoet on 11/3/19.
// ✌️
//

import SwiftUI


struct MissionDetailsContainerView: View {
    @EnvironmentObject var store: AppStore
    let mission: Mission
}



// MARK: - Body
extension MissionDetailsContainerView {

    var body: some View {
        GeometryReader { geometry in
            MissionDetailsView(
                viewModel: MissionDetailsViewModel(store: self.store, mission: self.mission),
                geometry: geometry
            )
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
}



// MARK: - Preview
struct MissionDetailsContainerView_Previews: PreviewProvider {

    static var previews: some View {
        let store = SampleStore.default
        
        return MissionDetailsContainerView(mission: store.state.missionsState.missions[0])
            .environmentObject(SampleStore.default)
    }
}
