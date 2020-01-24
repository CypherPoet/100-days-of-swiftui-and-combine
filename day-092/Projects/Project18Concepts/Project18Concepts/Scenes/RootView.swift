//
//  RootView.swift
//  Project18Concepts
//
//  Created by CypherPoet on 1/23/20.
// ✌️
//

import SwiftUI


struct RootView {

}


// MARK: - View
extension RootView: View {

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Day 92").font(.headline)) {
                    NavigationLink(
                        "Alignment & Alignment Guides",
                        destination: AlignmentAndGuidesExample()
                    )
                    NavigationLink(
                        "Custom Alignment Guides",
                        destination: CustomAlignmentGuidesExample()
                    )
                }
            }
            .navigationBarTitle("Geometry & Layout")
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
