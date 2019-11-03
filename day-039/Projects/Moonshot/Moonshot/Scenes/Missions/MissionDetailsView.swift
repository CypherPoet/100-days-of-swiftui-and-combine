//
//  MissionDetailsView.swift
//  Moonshot
//
//  Created by CypherPoet on 11/3/19.
// ✌️
//

import SwiftUI


struct MissionDetailsView: View {
    let mission: Mission
}


// MARK: - Computeds
extension MissionDetailsView {


}


// MARK: - Body
extension MissionDetailsView {

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                    
                    Text(self.mission.description)
                        .padding()
                    
                    Spacer(minLength: 25)
                }
                .padding()
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
}


// MARK: - View Variables
extension MissionDetailsView {


}



// MARK: - Preview
struct MissionDetailsView_Previews: PreviewProvider {

    static var previews: some View {
        MissionDetailsView(mission: generateSampleMissions()[0])
    }
}
