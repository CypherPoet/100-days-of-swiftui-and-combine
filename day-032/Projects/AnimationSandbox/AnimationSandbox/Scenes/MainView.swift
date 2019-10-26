//
//  MainView.swift
//  AnimationSandbox
//
//  Created by CypherPoet on 10/25/19.
// ✌️
//

import SwiftUI


struct MainView: View {
    @State private var scaleDuration: Double = 0.4
    @State private var currentBlurRadius: CGFloat = 0.0
    @State private var buttonScale: CGFloat = 1.0
    @State private var ringOpacity: Double = 1.0
    @State private var ringScale: CGFloat = 0
    @State private var buttonYRotation: Double = 0.0
}


// MARK: - Body
extension MainView {

    var body: some View {
        
        VStack(spacing: 60) {
            Button(action: {
                withAnimation(.easeInOut(duration: 1.0)) {
                    self.buttonYRotation += (2.0 * .pi)
                }
            }) {
                Text("Tap Me")
                    .foregroundColor(.black)
                    .padding(100)
                    .background(Color.accentColor)
                    .clipShape(Circle())
            }
            .blur(radius: currentBlurRadius / 3)
//            .animation(
//                Animation.easeInOut(duration: duration)
//                    .delay(0.1)
//                    .repeatCount(3, autoreverses: true)
//            )
            .scaleEffect(buttonScale)
            .animation(.easeOut(duration: scaleDuration))
            .rotation3DEffect(.radians(buttonYRotation), axis: (x: 0, y: 1, z: 0))
            .overlay(pulseRing)
            .onAppear {
                self.ringScale = 2
                self.ringOpacity = 0
            }
            
            
            VStack {
                 Text("Button Scale")
                
                Slider(
                    value: $buttonScale,
                    in: 0.1...1.0,
                    minimumValueLabel: Text("0.1"),
                    maximumValueLabel: Text("1")
                ) {
                    Text("Button Scale")
                }
            }
        }
        .padding()
        
    }
}


// MARK: - View Variables
extension MainView {
    
    var pulseRing: some View {
        Circle()
            .stroke(Color.accentColor, lineWidth: 4)
            .opacity(ringOpacity)
            .scaleEffect(ringScale)
            .animation(
                Animation
                    .easeOut(duration: 1.0)
                    .repeatForever(autoreverses: false)
            )
    }
}


// MARK: - Preview
struct MainView_Previews: PreviewProvider {

    static var previews: some View {
        MainView()
            .accentColor(.pink)
    }
}
