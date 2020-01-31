//
//  RootView.swift
//  PadFinder
//
//  Created by CypherPoet on 1/31/20.
// ✌️
//

import SwiftUI


struct RootView {
    @EnvironmentObject private var store: AppStore
}


// MARK: - View
extension RootView: View {
    

    var body: some View {
        NavigationView {
            PadsListContainerView()
            
            WelcomeView()
        }
    }
}


// MARK: - Computeds
extension RootView {
}


// MARK: - View Variables
extension RootView {
}


// MARK: - Private Helpers
private extension RootView {
}



// MARK: - Preview
struct RootView_Previews: PreviewProvider {

    static var previews: some View {
        RootView()
    }
}
