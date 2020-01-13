
//
//  UserQRCodeView.swift
//  QRConnections
//
//  Created by CypherPoet on 1/11/20.
// ✌️
//

import SwiftUI


struct UserQRCodeView {
    let cgImage: CGImage?
}


// MARK: - View
extension UserQRCodeView: View {

    var body: some View {
        GeometryReader { geometry in
            if self.cgImage != nil {
                HStack {
                    Spacer()
                    Image(uiImage: .init(cgImage: self.cgImage!))
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(height: geometry.size.height)
                        .transition(
                            AnyTransition
                                .scale(scale: 0, anchor: .center)
                                .animation(Animation.easeOut(duration: 0.4))
                        )
                    Spacer()
                }
            } else {
                self.noQRCodeView
            }
        }
        .padding()
    }
}


// MARK: - Computeds
extension UserQRCodeView {}


// MARK: - View Variables
extension UserQRCodeView {
    
    var noQRCodeView: some View {
        VStack(spacing: 22) {
            Image(systemName: "xmark.square")
                .resizable()
                .scaledToFit()
            
            Text("Begin entering your information to generate a QR Code.")
                .layoutPriority(1)
                .padding()
        }
    }
}


// MARK: - Private Helpers
private extension UserQRCodeView {
}



//// MARK: - Preview
//struct UserQRCodeView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        UserQRCodeView(cgImage: )
//    }
//}
