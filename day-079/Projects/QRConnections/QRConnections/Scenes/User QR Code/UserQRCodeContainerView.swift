//
//  UserQRCodeContainerView.swift
//  QRConnections
//
//  Created by CypherPoet on 1/13/20.
// ✌️
//

import SwiftUI



struct UserQRCodeContainerView {
    @EnvironmentObject private var store: AppStore
    @ObservedObject var viewModel: ViewModel
}


// MARK: - View
extension UserQRCodeContainerView: View {
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.qrCodeCGImage != nil {
                    UserQRCodeView(cgImage: viewModel.qrCodeCGImage!)
                        .transition(
                            AnyTransition
                                .move(edge: .top)
                                .animation(Animation.easeOut(duration: 0.4))
                        )
                }
        
                
                UserQRCodeFormView(
                    viewModel: .init(userProfileState: viewModel.userProfileState)
                )
            }
            .navigationBarTitle("Your QR")
        }
        .onAppear {
            let qrCodeData = self.viewModel.userProfileState.qrCodeData
            
            if self.viewModel.qrCodeCGImage == nil && !qrCodeData.isEmpty {
                self.store.send(UserProfileSideEffect.generateQRCode(data: qrCodeData))
            }
        }
    }
}



// MARK: - Computeds
extension UserQRCodeContainerView {
}


// MARK: - View Variables
extension UserQRCodeContainerView {
}


// MARK: - Private Helpers
private extension UserQRCodeContainerView {
}



// MARK: - Preview
struct UserQRCodeContainerView_Previews: PreviewProvider {

    static var previews: some View {
        let store = SampleData.appStore
        
        return UserQRCodeContainerView(
            viewModel: .init(userProfileState: store.state.userProfileState)
        )
        .environmentObject(store)
    }
}
