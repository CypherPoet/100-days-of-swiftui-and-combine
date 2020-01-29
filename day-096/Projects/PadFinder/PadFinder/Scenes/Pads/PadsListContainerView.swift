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
        NavigationView {
            PadsListView(
                viewModel: .init(padsState: padsState),
                buildDestination: buildDestination(forPad:)
            )
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
    
    
//    func makeSnapshotter(for pad: Pad) -> MKMapSnapshotter {
//        let snapshotOptions = pad.baseSnapshotOptions
//
//        snapshotOptions.size = CGSize(width: 200, height: 200)
//
//
//        return MKMapSnapshotter(options: snapshotOptions)
//    }
    
    
    func makeSnapshotOptions(for pad: Pad) -> MKMapSnapshotter.Options {
        let snapshotOptions = pad.baseSnapshotOptions

        return snapshotOptions
    }
    
    
//    func makeSnapshotService(for pad: Pad) -> MKMapSnapshotter {
//        let service = MapSnapshottingService.shared
//        let snapshotOptions = pad.baseSnapshotOptions
//
//        snapshotOptions.size = CGSize(width: 300, height: 300)
//
//
//        return MKMapSnapshotter(options: snapshotOptions)
//    }
//
    
    func buildDestination(forPad pad: Pad) -> some View {
        PadDetailsView(
            viewModel: .init(
                pad: pad,
                snapshotService: MapSnapshottingService(
//                    snapshotter: makeSnapshotter(for: pad)
                    snapshotOptions: makeSnapshotOptions(for: pad)
                )
                
            )
        )
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
