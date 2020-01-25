//
//  CrewMemberDetails.swift
//  Moonshot
//
//  Created by CypherPoet on 11/3/19.
// ✌️
//

import SwiftUI


struct CrewMemberDetails: View {
    private(set) var viewModel: CrewMemberDetailsViewModel
}


// MARK: - Body
extension CrewMemberDetails {
    
    var body: some View {
        List {
            
            Section {
                Image(decorative: viewModel.astronautImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.horizontal)
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            
            Section(header: Text(viewModel.roleTitleText)) {
                Text(viewModel.role)
                    .padding(.vertical)
            }
            
            
            if !viewModel.otherMissionRoles.isEmpty {
                Section(header: Text("Other Mission Roles")) {
                    ForEach(viewModel.otherMissionRoles, id: \.missionName) { (missionName, role) in
                        Text("\(missionName):").fontWeight(.bold)
                            + Text(" \(role)")
                    }
                    .padding(.vertical)
                }
            }
            
            
            Section(header: Text("Bio")) {
                Text(viewModel.astronautDescription)
                    .padding(.vertical)
            }
        }
        .navigationBarTitle(viewModel.astronautName)
    }
}


// MARK: - Preview
struct CrewMemberDetails_Previews: PreviewProvider {
    
    static var previews: some View {
        CrewMemberDetails(
            viewModel: CrewMemberDetailsViewModel(
                store: SampleStore.default,
                astronaut: SampleAstronautsState.default.astronauts[6],
                role: "Star Fleet Adrimal",
                mission: SampleMissionsState.default.missions[0]
            )
        )
    }
}
