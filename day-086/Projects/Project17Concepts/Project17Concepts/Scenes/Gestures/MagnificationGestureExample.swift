//
//  MagnificationGestureExample.swift
//  Project17Concepts
//
//  Created by CypherPoet on 1/16/20.
// ✌️
//

import SwiftUI


struct MagnificationGestureExample {
    @GestureState private var magnificationState: CGFloat = 1.0
}


// MARK: - View
extension MagnificationGestureExample: View {

    var body: some View {
        VStack {
            Spacer()
            
            Image("paris")
                .resizable()
                .scaledToFit()
                .scaleEffect(magnificationState)
                .gesture(magnificationGesture)
            
            Text("Magnify Me")
                .font(.headline)
                    
            Spacer()
        }
        .navigationBarTitle("Magnification")
    }
}


// MARK: - Computeds
extension MagnificationGestureExample {


}


// MARK: - View Variables
extension MagnificationGestureExample {

    var magnificationGesture: some Gesture {
        MagnificationGesture()
            .updating($magnificationState) { (magnificationValue, state, transaction) in
                state = magnificationValue
            }
            .onChanged { value in
                print("onChanged || Value: \(value)")
            }
            .onEnded { value in
                print("onEnded || Value: \(value)")
           }
    }
}



// MARK: - Preview
struct MagnificationGestureExample_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            MagnificationGestureExample()
        }
    }
}
