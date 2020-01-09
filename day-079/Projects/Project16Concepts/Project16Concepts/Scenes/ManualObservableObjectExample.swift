//
//  ManualObservableObjectExample.swift
//  Project16Concepts
//
//  Created by CypherPoet on 1/8/20.
// ✌️
//

import SwiftUI



struct ManualObservableObjectExample: View {
    @ObservedObject var viewModel = ViewModel()
}


// MARK: - Body
extension ManualObservableObjectExample {

    var body: some View {
        Text("The current value is: \(viewModel.currentValue)")
    }
}


// MARK: - ViewModel
extension ManualObservableObjectExample {
    
    public final class ViewModel: ObservableObject {
//        @Published var currentValue = 0
        
        var currentValue = 0 {
            willSet {
                self.objectWillChange.send()
            }
        }
        
        
        init() {
            performUpdate()
        }
        
        
        func performUpdate() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.currentValue += 1

                if self.currentValue < 10 {
                    self.performUpdate()
                }
            }
        }
    }
}


// MARK: - Preview
struct ManualObservableObjectExample_Previews: PreviewProvider {

    static var previews: some View {
        ManualObservableObjectExample()
    }
}
