//
//  MissionsListContainerView.swift
//  SpaceXPayloadStats
//
//  Created by CypherPoet on 11/23/19.
// ✌️
//

import SwiftUI


struct MissionsListContainerView: View {
    @EnvironmentObject private(set) var store: AppStore
}


// MARK: - Body
extension MissionsListContainerView {

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello World!"/*@END_MENU_TOKEN@*/)
    }
}


// MARK: - Computeds
extension MissionsListContainerView {


}


// MARK: - View Variables
extension MissionsListContainerView {


}



// MARK: - Preview
struct MissionsListContainerView_Previews: PreviewProvider {

    static var previews: some View {
        MissionsListContainerView()
            .environmentObject(SampleStore.noModels)
    }
}
