//
//  MainView.swift
//  DrawingSandbox
//
//  Created by CypherPoet on 11/5/19.
// ✌️
//

import SwiftUI


struct MainView: View {
}


// MARK: - Computeds
extension MainView {


}


// MARK: - Body
extension MainView {

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Day 43")) {
                    NavigationLink(destination: TrianglePathExample()) {
                        Text("Basic Triangle Path")
                    }
                    NavigationLink(destination: CustomShapesExample()) {
                        Text("Custom Shapes")
                    }
                }
                
                Section(header: Text("Day 44")) {
                    NavigationLink(destination: RadialFlowerExample()) {
                        Text("CGAffineTransform & Even-Odd Fills")
                    }
                    
                    NavigationLink(destination: ColorGradientCyclingExample()) {
                         Text("Activating Metal Rendering")
                     }
                }
                
                Section(header: Text("Day 45")) {
                    NavigationLink(destination: BlendModesListView()) {
                        Text("All the Blend modes")
                    }

                    NavigationLink(destination: ScreenedCirclesExample()) {
                        Text("Screened Circles")
                    }
                    
                    NavigationLink(destination: AnimatableDataExample()) {
                        Text("Animating Custom Shapes w/ AnimatableData")
                    }
                    
                    NavigationLink(destination: AnimatablePairExample()) {
                        Text("Using AnimatablePair for multiple properties")
                    }
                    
                    NavigationLink(destination: SpirographExample()) {
                        Text("Drawing a Spirograph")
                    }
                }
                
                Section(header: Text("Day 46: Challenges")) {
                    NavigationLink(destination: ArrowExample()) {
                        Text("Custom Arrow Shape")
                    }
                }
            }
            .navigationBarTitle("SwiftUI Drawing")
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
    }
}
