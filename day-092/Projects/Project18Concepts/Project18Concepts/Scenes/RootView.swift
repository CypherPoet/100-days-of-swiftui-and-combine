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
                
                Section(header: Text("Day 93").font(.headline)) {
                    NavigationLink(
                        "Absolute Positioning",
                        destination: AbsolutePositioningExample()
                    )
                    NavigationLink(
                        "GeometryReader & Coordinate Spaces",
                        destination: GeometryReaderAndCoordinatesExample()
                    )
                    NavigationLink(
                        "Scroll View Effects with GeometryReaders (1)",
                        destination: NestedGeometryReadersHelixExample()
                    )
                    NavigationLink(
                        "Scroll View Effects with GeometryReaders (2)",
                        destination: NestedGeometryReadersCoverFlowExample()
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
