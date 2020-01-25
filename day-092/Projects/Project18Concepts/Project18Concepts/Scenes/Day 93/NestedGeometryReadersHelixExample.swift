//
//  NestedGeometryReadersHelixExample.swift
//  Project18Concepts
//
//  Created by CypherPoet on 1/24/20.
// ✌️
//

import SwiftUI


struct NestedGeometryReadersHelixExample {
}


// MARK: - View
extension NestedGeometryReadersHelixExample: View {

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                SpinningHelixView(container: geometry)
            }
        }
    }
}


// MARK: - Computeds
extension NestedGeometryReadersHelixExample {
}


// MARK: - View Variables
extension NestedGeometryReadersHelixExample {
}


// MARK: - Private Helpers
private extension NestedGeometryReadersHelixExample {
}



// MARK: - Preview
struct GeometryReaderScrollViewExample_Previews: PreviewProvider {

    static var previews: some View {
        NestedGeometryReadersHelixExample()
    }
}
