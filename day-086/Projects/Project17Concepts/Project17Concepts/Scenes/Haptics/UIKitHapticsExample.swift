//
//  UIKitHapticsExample.swift
//  Project17Concepts
//
//  Created by CypherPoet on 1/17/20.
// ✌️
//

import SwiftUI


struct UIKitHapticsExample {
    let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
}


// MARK: - View
extension UIKitHapticsExample: View {

    var body: some View {
        VStack(spacing: 22) {
                Button(action: {
                    self.notificationFeedbackGenerator.notificationOccurred(.success)
                }) {
                    Text("Success")
                        .foregroundColor(.primary)
                        .padding()
                        .frame(width: 188)
                }
                .background(Color.green)
                .cornerRadius(8)
                .shadow(radius: 4)
            
                
                Button(action: {
                    self.notificationFeedbackGenerator.notificationOccurred(.warning)
                }) {
                    Text("Warning")
                        .foregroundColor(.primary)
                        .padding()
                        .frame(width: 188)
                }
                .background(Color.yellow)
                .cornerRadius(8)
                .shadow(radius: 4)
            
            
                Button(action: {
                    self.notificationFeedbackGenerator.notificationOccurred(.error)
                }) {
                    Text("Error")
                        .foregroundColor(.primary)
                        .padding()
                        .frame(width: 188)
                }
                .background(Color.red)
                .cornerRadius(8)
                .shadow(radius: 4)
            
        }.onAppear {
            self.notificationFeedbackGenerator.prepare()
        }
    }
}


// MARK: - Computeds
extension UIKitHapticsExample {
}


// MARK: - View Variables
extension UIKitHapticsExample {
}


// MARK: - Private Helpers
private extension UIKitHapticsExample {
}



// MARK: - Preview
struct UIKitHapticsExample_Previews: PreviewProvider {

    static var previews: some View {
        UIKitHapticsExample()
    }
}
