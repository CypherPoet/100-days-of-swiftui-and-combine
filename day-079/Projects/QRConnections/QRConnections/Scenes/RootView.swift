//
//  RootView.swift
//  QRConnections
//
//  Created by CypherPoet on 1/9/20.
// ✌️
//

import SwiftUI


struct RootView: View {
    @EnvironmentObject private var store: AppStore
    
    enum Tab {
        case collectedContacts
        case userQRCode
    }
    
    @State private var activeTab: Tab = .collectedContacts
}


// MARK: - Body
extension RootView {

    var body: some View {
        
        TabView {
            ContactsContainerView(viewModel: .init())
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Collected Contacts")
                }
                .tag(Tab.collectedContacts)
                
            
            UserQRCodeContainerView(viewModel: .init(userProfileState: userProfileState))
                .tabItem {
                    Image(systemName: "qrcode")
                    Text("Your QR")
                }
                .tag(Tab.userQRCode)
        }
//        .environmentObject(store)
        .edgesIgnoringSafeArea(.top)
    }
}


// MARK: - Computeds
extension RootView {
    var userProfileState: UserProfileState { store.state.userProfileState }
}


// MARK: - View Variables
extension RootView {


}



// MARK: - Preview
struct RootView_Previews: PreviewProvider {

    static var previews: some View {
        RootView()
            .environmentObject(SampleData.appStore)
    }
}
