//
//  PadsListContainerView.swift
//  PadFinder
//
//  Created by CypherPoet on 1/26/20.
// ✌️
//

import SwiftUI
import MapKit


struct PadsListContainerView {
    @EnvironmentObject private var store: AppStore
}


// MARK: - View
extension PadsListContainerView: View {

    var body: some View {
        PadsListView(
            viewModel: .init(padsState: padsState),
            buildDestination: buildDestination(forPad:)
        )
        .navigationBarTitle("Launch Pads")
        .environmentObject(store)
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
    

    func makeSnapshotOptions(for pad: Pad) -> MKMapSnapshotter.Options {
        let snapshotOptions = pad.baseSnapshotOptions

        return snapshotOptions
    }
    

    func toggleFavorite(for pad: Pad) {
        if padsState.favorites.contains(pad.id) {
            store.send(.pads(.favoriteRemoved(pad.id)))
        } else {
            store.send(.pads(.favoriteAdded(pad.id)))
        }
    }


    func buildDestination(forPad pad: Pad) -> some View {
        PadDetailsContainerView(pad: pad)
    }
}




// MARK: - Preview
struct PadsListContainerView_Previews: PreviewProvider {

    static var previews: some View {
        let store = PreviewData.AppStores.withPads
        
        return PadsListContainerView()
            .environmentObject(store)
    }
}
