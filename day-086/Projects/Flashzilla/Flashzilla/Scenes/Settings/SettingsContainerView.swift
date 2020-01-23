//
//  SettingsContainerView.swift
//  Flashzilla
//
//  Created by CypherPoet on 1/22/20.
// ✌️
//

import SwiftUI


struct SettingsContainerView: View {
}


// MARK: - Body
extension SettingsContainerView {

    var body: some View {
        NavigationView {
            SettingsFormView()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


// MARK: - Computeds
extension SettingsContainerView {
}


// MARK: - View Variables
extension SettingsContainerView {
}



// MARK: - Preview
struct SettingsContainerView_Previews: PreviewProvider {

    static var previews: some View {
        SettingsContainerView()
            .environmentObject(PreviewData.AppStores.default)
    }
}
