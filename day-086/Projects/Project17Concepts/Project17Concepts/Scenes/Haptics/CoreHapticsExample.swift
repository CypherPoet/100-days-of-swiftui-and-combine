//
//  CoreHapticsExample.swift
//  Project17Concepts
//
//  Created by CypherPoet on 1/18/20.
// ✌️
//

import SwiftUI
import CoreHaptics


enum HapticEventList {
    static let standardSuccess = [
        CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 1),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 1),
            ],
            relativeTime: 0
        )
    ]
}


struct HapticsState {
    var supportsHaptics: Bool
    
    init() {
        self.supportsHaptics = CHHapticEngine.capabilitiesForHardware().supportsHaptics
    }
}



struct CoreHapticsExample {
    @ObservedObject var viewModel = ViewModel(hapticsState: .init())
}



// MARK: - View
extension CoreHapticsExample: View {

    var body: some View {
        VStack(spacing: 42) {
            Text("Haptics Support: \(viewModel.supportsHaptics ? "Enabled" : "Disabled")")
            
            Button(action: {
                try? self.viewModel.hapticsPlayer?.start(atTime: CHHapticTimeImmediate)
            }) {
                Text("Success")
                    .foregroundColor(.primary)
                    .padding()
                    .frame(width: 188)
            }
            .background(Color.green)
            .cornerRadius(8)
            .shadow(radius: 4)
            .disabled(!viewModel.supportsHaptics)
        }
        .onAppear(perform: viewModel.onAppear)
    }
}


// MARK: - Computeds
extension CoreHapticsExample {
}


// MARK: - View Variables
extension CoreHapticsExample {
}


// MARK: - Private Helpers
private extension CoreHapticsExample {
}



// MARK: - Preview
struct CoreHapticsExample_Previews: PreviewProvider {

    static var previews: some View {
        CoreHapticsExample()
    }
}
