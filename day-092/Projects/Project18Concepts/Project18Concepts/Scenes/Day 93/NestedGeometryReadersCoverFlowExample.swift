//
//  NestedGeometryReadersCoverFlowExample.swift
//  Project18Concepts
//
//  Created by CypherPoet on 1/24/20.
// ✌️
//

import SwiftUI


struct NestedGeometryReadersCoverFlowExample {
}


// MARK: - View
extension NestedGeometryReadersCoverFlowExample: View {

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                SideScrollingRectangleFlowView(container: geometry)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}



// MARK: - Computeds
extension NestedGeometryReadersCoverFlowExample {
}


// MARK: - View Variables
extension NestedGeometryReadersCoverFlowExample {
}


// MARK: - Private Helpers
private extension NestedGeometryReadersCoverFlowExample {
}



// MARK: - Preview
struct NestedGeometryReadersCoverFlowExample_Previews: PreviewProvider {

    static var previews: some View {
        NestedGeometryReadersCoverFlowExample()
    }
}
