//
//  PadsListContainerView.swift
//  PadFinder
//
//  Created by CypherPoet on 1/26/20.
// ✌️
//

import SwiftUI


struct PadsListContainerView {
    @EnvironmentObject private var store: AppStore
}


// MARK: - View
extension PadsListContainerView: View {

    var body: some View {
        NavigationView {
            PadsListView(viewModel: .init(padsState: padsState))
                .navigationBarTitle("Launch Pads")
            
            WelcomeView()
        }
        .onAppear(perform: fetchPads)
    }
}


// MARK: - Computeds
extension PadsListContainerView {
    
    var padsState: PadsState { store.state.padsState }
}


// MARK: - View Variables
extension PadsListContainerView {
}


// MARK: - Private Helpers
private extension PadsListContainerView {
    
    func fetchPads() {
        store.send(PadsSideEffect.fetchPads)
    }
}



// MARK: - Preview
struct PadsListContainerView_Previews: PreviewProvider {

    static var previews: some View {
        let store = PreviewData.AppStores.withPads
        
        return PadsListContainerView(
//            viewModel: .init(
//                padsState: store.state.padsState
//            )
        )
        .environmentObject(store)
    }
}
