//
//  MainView.swift
//  AnimationSandbox
//
//  Created by CypherPoet on 10/25/19.
// ✌️
//

import SwiftUI


struct MainView: View {
}


// MARK: - Body
extension MainView {

    var body: some View {
        
        NavigationView {
            List {
                NavigationLink(destination: PulseRingView()) {
                    Text("Pulse Ring")
                }
                NavigationLink(destination: DraggingGradientExample()) {
                    Text("Draggable Gradient")
                }
                NavigationLink(destination: SnakyLettersExample()) {
                    Text("Snaky Letters")
                }
                NavigationLink(destination: VisibilityTransitionExample()) {
                    Text("Show/Hide View Transitions")
                }
                NavigationLink(destination: CornerRotationExample()) {
                    Text("Custom Rotation View Modifier")
                }
            }
        }
    }
}


// MARK: - View Variables
extension MainView {
    

}


// MARK: - Preview
struct MainView_Previews: PreviewProvider {

    static var previews: some View {
        MainView()
            .accentColor(.pink)
    }
}
