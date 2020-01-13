//
//  UserQRCodeFormView.swift
//  QRConnections
//
//  Created by CypherPoet on 1/13/20.
// ✌️
//

import SwiftUI


struct UserQRCodeFormView: View {
    @EnvironmentObject private var store: AppStore
    @ObservedObject var viewModel: ViewModel
}


// MARK: - Body
extension UserQRCodeFormView {

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $viewModel.userNameText)
            }
        }
        .onReceive(viewModel.$userName.dropFirst(1)) { name in
            self.store.send(.userProfile(.userNameSet(name)))
        }
        .onReceive(viewModel.$qrCodeData.dropFirst(1)) { data in
            self.store.send(UserProfileSideEffect.generateQRCode(data: data))
        }
    }
}


// MARK: - Computeds
extension UserQRCodeFormView {}


// MARK: - View Variables
extension UserQRCodeFormView {}



// MARK: - Preview
struct UserQRCodeFormView_Previews: PreviewProvider {

    static var previews: some View {
        let store = SampleData.appStore
        
        return UserQRCodeFormView(viewModel: .init(userProfileState: store.state.userProfileState))
            .environmentObject(store)
    }
}
