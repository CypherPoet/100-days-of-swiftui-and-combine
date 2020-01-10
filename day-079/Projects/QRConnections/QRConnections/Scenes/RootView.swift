//
//  RootView.swift
//  QRConnections
//
//  Created by CypherPoet on 1/9/20.
// ✌️
//

import SwiftUI


struct RootView: View {
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
                
            Text("")
                .tabItem {
                    Image(systemName: "qrcode")
                    Text("My Alias")
                }
                .tag(Tab.userQRCode)
        }
        .edgesIgnoringSafeArea(.top)
    }
}


// MARK: - Computeds
extension RootView {


}


// MARK: - View Variables
extension RootView {


}



// MARK: - Preview
struct RootView_Previews: PreviewProvider {

    static var previews: some View {
        RootView()
    }
}
