//
//  CoreHapticsExample+ViewModel.swift
//  Project17Concepts
//
//  Created by CypherPoet on 1/18/20.
// ✌️
//

import Foundation
import CoreHaptics



extension CoreHapticsExample {
    
    final class ViewModel: ObservableObject {
        private let hapticsState: HapticsState
        private var hapticsEngine: CHHapticEngine!
        
        
        init(hapticsState: HapticsState = .init()) {
            self.hapticsState = hapticsState
        }
    }
}


extension CoreHapticsExample.ViewModel {
    var supportsHaptics: Bool { hapticsState.supportsHaptics }
    
    
    var hapticsPlayer: CHHapticPatternPlayer? {
        do {
            let pattern = try CHHapticPattern(events: HapticEventList.standardSuccess, parameters: [])
        
            return try hapticsEngine.makePlayer(with: pattern)
        } catch {
            // TODO: Better error handling here?
            return nil
        }
    }
}

extension CoreHapticsExample.ViewModel {
    
    func onAppear() {
        guard supportsHaptics else {
            print("No haptics support")
            return
        }
        
        do {
            self.hapticsEngine = try CHHapticEngine()
            try self.hapticsEngine.start()
        } catch {
            print("Error while making haptics engine: \(error.localizedDescription)")
        }
    }
}
