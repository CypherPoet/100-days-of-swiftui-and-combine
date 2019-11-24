//
//  MissionDetailsView.swift
//  SpaceXPayloadStats
//
//  Created by CypherPoet on 11/23/19.
// ✌️
//

import SwiftUI


struct MissionDetailsView<Destination: View>: View {
    let mission: Mission
    let buildDestination: ((Payload.ID) -> Destination)
}


// MARK: - Body
extension MissionDetailsView {
    
    var body: some View {
        ScrollView(.vertical) {
            
            Text(mission.description)
                .padding()
            
            
            if !mission.payloadIDs.isEmpty {
                HStack {
                    Spacer()
                    Text("Payload History")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.top)
                    Spacer()
                }
                
                List {
                    ForEach(mission.payloadIDs, id: \.self) { payloadID in
                        NavigationLink(destination: self.buildDestination(payloadID)) {
                            Text(payloadID)
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(mission.name), displayMode: .inline)
    }
}


// MARK: - Computeds
extension MissionDetailsView {
    
    
}


// MARK: - View Variables
extension MissionDetailsView {
    
    
}



// MARK: - Preview
struct MissionDetailsView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            MissionDetailsView(
                mission: SampleMissions.telstar,
                buildDestination: { _ in EmptyView() }
            )
        }
    }
}
