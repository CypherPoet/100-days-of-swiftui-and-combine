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
                NavigationLink(destination: TrianglePathExample()) {
                    Text("Basic Triangle Path")
                }
                NavigationLink(destination: CustomShapesExample()) {
                    Text("Custom Shapes")
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
