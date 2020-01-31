//
//  WelcomeView.swift
//  PadFinder
//
//  Created by CypherPoet on 1/31/20.
// ✌️
//

import SwiftUI


struct WelcomeView {

}


// MARK: - View
extension WelcomeView: View {

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
extension WelcomeView {
}


// MARK: - View Variables
extension WelcomeView {
}


// MARK: - Private Helpers
private extension WelcomeView {
}



// MARK: - Preview
struct WelcomeView_Previews: PreviewProvider {

    static var previews: some View {
        WelcomeView()
    }
}
