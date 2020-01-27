//
//  WelcomeView.swift
//  PadFinder
//
//  Created by CypherPoet on 1/27/20.
// ✌️
//

import SwiftUI


extension PadsListContainerView {
    struct WelcomeView {

    }
}


// MARK: - View
extension PadsListContainerView.WelcomeView: View {

    var body: some View {
        
        VStack(spacing: 20.0) {
            Text("Welcome to PadFinder! 🚀")
                .font(.largeTitle)
            
            Text("Select a launch pad from the side menu to get started. (Try swiping from the left edge if you don't see it!)")
                .font(.headline)
                .foregroundColor(.secondary)
            
        }
        .padding()
    }
}


// MARK: - Computeds
extension PadsListContainerView.WelcomeView {
}


// MARK: - View Variables
extension PadsListContainerView.WelcomeView {
}


// MARK: - Private Helpers
private extension PadsListContainerView.WelcomeView {
}


// MARK: - Preview
struct PadsListContainerView_WelcomeView_Previews: PreviewProvider {

    static var previews: some View {
        PadsListContainerView.WelcomeView()
    }
}

