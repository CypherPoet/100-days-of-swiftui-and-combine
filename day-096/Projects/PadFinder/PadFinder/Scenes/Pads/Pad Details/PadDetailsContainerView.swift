//
//  PadDetailsContainerView.swift
//  PadFinder
//
//  Created by CypherPoet on 1/29/20.
// ✌️
//


import SwiftUI
import MapKit


struct PadDetailsContainerView {
    @EnvironmentObject private var store: AppStore

    let pad: Pad
}


// MARK: - View
extension PadDetailsContainerView: View {

    var body: some View {
        PadDetailsView(
            viewModel: .init(
                pad: pad,
                isPadFavorited: isPadFavorited,
                snapshotService: MapSnapshottingService(
                    snapshotOptions: makeSnapshotOptions(for: pad)
                )
            ),
            onFavoriteToggled: toggleFavorite(for:)
        )
    }
}


// MARK: - Computeds
extension PadDetailsContainerView {
    var padsState: PadsState { store.state.padsState }
    var isPadFavorited: Bool { padsState.favorites.contains(pad.id) }
}


// MARK: - View Variables
extension PadDetailsContainerView {
}


// MARK: - Private Helpers
private extension PadDetailsContainerView {
    
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
}



//// MARK: - Preview
//struct PadDetailsContainerView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        PadDetailsContainerView()
//    }
//}
