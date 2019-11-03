//
//  MissionDetailsView.swift
//  Moonshot
//
//  Created by CypherPoet on 11/3/19.
// ✌️
//

import SwiftUI


struct MissionDetailsView: View {
    @ObservedObject private(set) var viewModel: MissionDetailsViewModel
    
    let geometry: GeometryProxy
}


// MARK: - Computeds
extension MissionDetailsView {


}


// MARK: - Body
extension MissionDetailsView {

    var body: some View {
        ScrollView(.vertical) {
            VStack {
                badgeImage
                
                Text(viewModel.missionDescription)
                    .padding()
                
                Spacer(minLength: 25)
                
                Text("Crew")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
                
                crewDetails
                    .padding(.horizontal)
            }
            .padding()
        }
    }
}


// MARK: - View Variables
extension MissionDetailsView {
    
    private var badgeImage: some View {
        Image(viewModel.imageName)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: geometry.size.width * 0.7)
    }
    
    
    private var crewDetails: some View {
        VStack(spacing: 12.0) {
            ForEach(viewModel.astronautsByRole, id: \.1) { (role, astronaut) in
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
}



// MARK: - Preview
struct MissionDetailsView_Previews: PreviewProvider {

    static var previews: some View {
        let store = SampleStore.default
        
        return GeometryReader { geometry in
            MissionDetailsView(
                viewModel: MissionDetailsViewModel(
                    store: store,
                    mission: store.state.missionsState.missions[0]
                ),
                geometry: geometry
            )
        }
        .environmentObject(store)
    }
}
