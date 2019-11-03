//
//  CrewMemberDetails.swift
//  Moonshot
//
//  Created by CypherPoet on 11/3/19.
// ✌️
//

import SwiftUI


struct CrewMemberDetails: View {
    let astronaut: Astronaut
    let role: String
}


// MARK: - Body
extension CrewMemberDetails {

    var body: some View {
        ScrollView {
            VStack {
                Image(self.astronaut.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                
                Text(astronaut.description)
                    .padding()
                    .layoutPriority(1)
                
                Spacer()
            }
            .navigationBarTitle(astronaut.name)
        }
    }
}


// MARK: - Preview
struct CrewMemberDetails_Previews: PreviewProvider {

    static var previews: some View {
        CrewMemberDetails(
            astronaut: SampleAstronautsState.default.astronauts[6],
            role: "Star Fleet Adrimal"
        )
    }
}
