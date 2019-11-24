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
//        ScrollView(.vertical) {
        List {
            
            Text(mission.description)
                .padding()
                .layoutPriority(1)
            
            
            if !mission.payloadIDs.isEmpty {
                Section(
                    header:
                        HStack {
                            Spacer()
                            Text("Payload History")
                                .font(.title)
                                .fontWeight(.light)
                            Spacer()
                        }
                        .padding(.vertical)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                ) {
                    List {
                        ForEach(mission.payloadIDs, id: \.self) { payloadID in
                            NavigationLink(destination: self.buildDestination(payloadID)) {
                                Text(payloadID)
                            }
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
        Group {
            NavigationView {
                MissionDetailsView(
                    mission: SampleMissions.telstar,
                    buildDestination: { _ in EmptyView() }
                )
            }
            
            NavigationView {
                MissionDetailsView(
                    mission: SampleMissions.idridiumNext,
                    buildDestination: { _ in EmptyView() }
                )
            }
        }
    }
}
