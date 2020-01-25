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
    let displayMode: DisplayMode
    
    
    init(
        mission: Mission,
        displayMode: DisplayMode = .launchDate
    ) {
        self.mission = mission
        self.displayMode = displayMode
    }
}


// MARK: - DisplayMode
extension MissionsListItemRow {
    enum DisplayMode {
        case launchDate
        case crew
    }
}


// MARK: - Computeds
extension MissionsListItemRow {

    private var crewNameString: String {
        mission.crew
            .map { $0.name }
            .joined(separator: ", ")
            .capitalized
    }
    
    
    private var subheadlineString: String {
        switch displayMode {
        case .crew:
            return crewNameString
        case .launchDate:
            return "Launch Date: \(mission.formattedLaunchDate)"
        }
    }
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
                
                Text(subheadlineString)
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
        Group {
            MissionsListItemRow(mission: generateSampleMissions()[0], displayMode: .launchDate)
            MissionsListItemRow(mission: generateSampleMissions()[0], displayMode: .crew)
        }
    }
}
