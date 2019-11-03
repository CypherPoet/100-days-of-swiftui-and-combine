//
//  MissionsListItemRow.swift
//  Moonshot
//
//  Created by CypherPoet on 11/3/19.
// ✌️
//

import SwiftUI


struct MissionsListItemRow: View {
    let mission: Mission
}


// MARK: - Computeds
extension MissionsListItemRow {


}


// MARK: - Body
extension MissionsListItemRow {

    var body: some View {
        HStack {
            Image(mission.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
    
            VStack(alignment: .leading) {
                Text("\(mission.displayName)")
                    .font(.headline)
                
                Text("Launch Date: \(mission.formattedLaunchDate)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}


// MARK: - View Variables
extension MissionsListItemRow {


}



// MARK: - Preview
struct MissionsListItemRow_Previews: PreviewProvider {

    static var previews: some View {
        MissionsListItemRow(mission: generateSampleMissions()[0])
    }
}
