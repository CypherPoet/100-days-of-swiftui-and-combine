
//
//  UserQRCodeView.swift
//  QRConnections
//
//  Created by CypherPoet on 1/11/20.
// ✌️
//

import SwiftUI


struct UserQRCodeView {
    let cgImage: CGImage
}


// MARK: - View
extension UserQRCodeView: View {

    var body: some View {
          Image(uiImage: .init(cgImage: cgImage))
    }
}


// MARK: - Computeds
extension UserQRCodeView {}


// MARK: - View Variables
extension UserQRCodeView {}


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
