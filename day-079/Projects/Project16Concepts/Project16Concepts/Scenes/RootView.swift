//
//  RootView.swift
//  Project16Concepts
//
//  Created by CypherPoet on 1/8/20.
// ✌️
//

import SwiftUI


struct RootView: View {
}


// MARK: - Body
extension RootView {

    var body: some View {
        
        NavigationView {
            List {
                NavigationLink(destination: ManualObservableObjectExample()) {
                    Text("Manual ObservableObject Change Publishing")
                }
                NavigationLink(destination: ImageInterpolationControlExample()) {
                    Text("Controlling Image Interpolation")
                }
            }
            .navigationBarTitle("Project 16 Concepts")
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
