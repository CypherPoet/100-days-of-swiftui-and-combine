//
//  MissionDetailsView.swift
//  SpaceXPayloadStats
//
//  Created by CypherPoet on 11/23/19.
// ✌️
//

import SwiftUI


struct MissionDetailsView: View {
    let mission: Mission
}


// MARK: - Body
extension MissionDetailsView {

    var body: some View {
        Text(mission.description)
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
        MissionDetailsView(mission: SampleMissions.telstar)
    }
}
