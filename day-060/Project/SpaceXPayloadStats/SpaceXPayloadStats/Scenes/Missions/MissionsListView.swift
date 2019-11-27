//
//  MissionsListView.swift
//  SpaceXPayloadStats
//
//  Created by CypherPoet on 11/23/19.
// ✌️
//

import SwiftUI


struct MissionsListView<Destination: View>: View {
    let buildDestination: ((Mission) -> Destination)
    
    @FetchRequest(fetchRequest: Mission.FetchRequest.all, animation: nil) var missions: FetchedResults<Mission>
}


// MARK: - Body
extension MissionsListView {

    var body: some View {
        List {
            ForEach(missions, id: \.self) { mission in
                NavigationLink(destination: self.buildDestination(mission)) {
                    Text(mission.name ?? "")
                }
            }
        }
        .navigationBarTitle("SpaceX Missions")
    }
}


// MARK: - Computeds
extension MissionsListView {
}


// MARK: - View Variables
extension MissionsListView {
}



// MARK: - Preview
struct MissionsListView_Previews: PreviewProvider {

    static var previews: some View {
        MissionsListView(
            buildDestination: { _ in EmptyView() }
        )
        .environment(\.managedObjectContext, SampleMOC.mainContext)
    }
}
