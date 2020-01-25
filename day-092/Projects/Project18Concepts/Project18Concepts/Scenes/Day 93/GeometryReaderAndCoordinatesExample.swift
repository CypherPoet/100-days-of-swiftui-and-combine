//
//  GeometryReaderAndCoordinatesExample.swift
//  Project18Concepts
//
//  Created by CypherPoet on 1/24/20.
// ✌️
//

import SwiftUI


struct GeometryReaderAndCoordinatesExample {
    enum CoordinateSpaceName {
        static let custom = "Custom"
    }
}


// MARK: - View
extension GeometryReaderAndCoordinatesExample: View {

    var body: some View {
        VStack {
            Text("Top")
            innerStack
                .background(Color.gray)
            Text("Bottom")
        }
        .background(Color.pink)
        .coordinateSpace(name: CoordinateSpaceName.custom)
    }
}


// MARK: - Computeds
extension GeometryReaderAndCoordinatesExample {
}


// MARK: - View Variables
extension GeometryReaderAndCoordinatesExample {

    private var innerStack: some View {
        
        HStack {
            Text("Left")
            
            GeometryReader { geometry in
                Text("Center")
                    .background(Color.blue)
                    .onTapGesture {
                        print("Global center: \(geometry.frame(in: .global).midX) x \(geometry.frame(in: .global).midY)")
                        print("Custom center: \(geometry.frame(in: .named(CoordinateSpaceName.custom)).midX) x \(geometry.frame(in: .named(CoordinateSpaceName.custom)).midY)")
                        print("Local center: \(geometry.frame(in: .local).midX) x \(geometry.frame(in: .local).midY)")
                    }
            }
            .background(Color.purple)
            
            Text("Right")
        }
    }
}


// MARK: - Private Helpers
private extension GeometryReaderAndCoordinatesExample {
}



// MARK: - Preview
struct GeometryReaderAndCoordinatesExample_Previews: PreviewProvider {

    static var previews: some View {
        GeometryReaderAndCoordinatesExample()
    }
}
