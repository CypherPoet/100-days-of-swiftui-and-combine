//
//  RootView.swift
//  Project17Concepts
//
//  Created by CypherPoet on 1/16/20.
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
                Section(header: Text("Gestures")) {
                    NavigationLink(
                        "Basic Long Press Gestures",
                        destination: BasicLongPressGestureExample()
                    )
                    
                    NavigationLink(
                        "Magnification Gesture",
                        destination: MagnificationGestureExample()
                    )
                    
                    NavigationLink(
                        "Rotation Gesture",
                        destination: RotationGestureExample()
                    )
                    
                    NavigationLink(
                        "Nested Gestures",
                        destination: NestedGesturesExample()
                    )
                    
                    NavigationLink(
                        "Gesture Sequencing",
                        destination: GestureSequencingExample()
                    )
                }
                
                Section(header: Text("Core Haptics")) {
                    NavigationLink(
                        "UIKit Haptics",
                        destination: UIKitHapticsExample()
                    )
                    
                    NavigationLink(
                        "Core Haptics",
                        destination: CoreHapticsExample()
                    )
                }
                
                Section(header: Text("Hit Testing")) {
                    NavigationLink(
                        "Allowing Hit Testing",
                        destination: AllowsHitTestingExample()
                    )
                    
                    NavigationLink(
                        "Specifying Content Shape",
                        destination: ContentShapeExample()
                    )
                }
            }
            .navigationBarTitle("Project 17 Concepts")
            .listStyle(GroupedListStyle())
        }
    }
}


// MARK: - Computeds
extension RootView {


}


// MARK: - View Variables
extension RootView {


}



// MARK: - Preview
struct RootView_Previews: PreviewProvider {

    static var previews: some View {
        RootView()
    }
}
