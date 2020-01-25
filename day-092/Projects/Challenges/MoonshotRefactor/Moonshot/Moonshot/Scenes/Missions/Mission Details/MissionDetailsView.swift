//
//  MissionDetailsView.swift
//  Moonshot
//
//  Created by CypherPoet on 11/3/19.
// ✌️
//

import SwiftUI


struct MissionDetailsView: View {
    @EnvironmentObject private var store: AppStore
    private(set) var viewModel: MissionDetailsViewModel
    
    let container: GeometryProxy
}


// MARK: - Computeds
extension MissionDetailsView {}


// MARK: - Body
extension MissionDetailsView {

    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 20) {
                
                badgeImage
                
                descriptionSection
                
                Text("Crew")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
                
                crewDetails
                    .padding(.horizontal)
    
                Spacer(minLength: 25)
            }
            .padding()
        }
    }
}


// MARK: - View Variables
extension MissionDetailsView {
    
    private var badgeImage: some View {
        GeometryReader { geometry in
            Image(decorative: self.viewModel.imageName)
                .resizable()
                .scaledToFit()
                .scaleEffect(self.scale(forHeaderImageWith: geometry))
                .animation(.easeOut(duration: 0.3))
                .frame(width: geometry.size.width)
        }
        .frame(height: self.container.size.width * 0.7)
    }
    
    
    private var descriptionSection: some View {
        VStack(spacing: 14) {
            if viewModel.missionLaunchDateText != nil {
                Text(viewModel.missionLaunchDateText!)
                    .font(.title)
                    .fontWeight(.semibold)
            }
            
            Text(viewModel.missionDescription)
                .padding()
        }
    }
    
    
    private var crewDetails: some View {
        VStack(spacing: 12.0) {
            ForEach(viewModel.astronautsByRole, id: \.1) { (role, astronaut) in
                NavigationLink(
                    destination: CrewMemberDetails(
                        viewModel: CrewMemberDetailsViewModel(
                            store: self.store,
                            astronaut: astronaut,
                            role: role,
                            mission: self.viewModel.mission
                        )
                    )
                ) {
                    CrewMemberItem(astronaut: astronaut, role: role)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
    
    
    private struct CrewMemberItem: View {
        let astronaut: Astronaut
        let role: String
        
        var body: some View {
            HStack {
                Image(astronaut.imageName)
                    .resizable()
                    .frame(width: 83, height: 60)
                    .clipShape(Capsule())
                    .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                
                VStack(alignment: .leading) {
                    Text(astronaut.name)
                        .font(.headline)
                    Text(role)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
        }
    }
}


// MARK: - Private Helpers
private extension MissionDetailsView {
    
    func scale(forHeaderImageWith geometry: GeometryProxy) -> CGFloat {
        geometry.frame(in: .global).minY > 40 ? 1.0 : 0.8
    }
}


// MARK: - Preview
struct MissionDetailsView_Previews: PreviewProvider {

    static var previews: some View {
        let store = SampleStore.default
        
        return GeometryReader { geometry in
            MissionDetailsView(
                viewModel: MissionDetailsViewModel(
                    store: store,
                    mission: store.state.missionsState.missions[1]
                ),
                container: geometry
            )
        }
        .environmentObject(store)
    }
}


