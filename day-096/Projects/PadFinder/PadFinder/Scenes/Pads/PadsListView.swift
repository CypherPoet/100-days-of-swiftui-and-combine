//
//  PadsListView.swift
//  PadFinder
//
//  Created by CypherPoet on 1/26/20.
// ✌️
//

import SwiftUI


struct PadsListView<Destination: View> {
    @ObservedObject var viewModel: ViewModel
    let buildDestination: ((Pad) -> Destination)
}


// MARK: - View
extension PadsListView: View {

    var body: some View {
        List(viewModel.pads) { pad in
            NavigationLink(destination: self.buildDestination(pad)) {
                HStack {
                    pad.padType.listItemImage
                    
                    VStack(alignment: .leading) {
                        Text(pad.name)
                            .foregroundColor(.primary)
                            .font(.headline)
                        
                        Text(pad.padType.displayName)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}


// MARK: - Computeds
extension PadsListView {
}


// MARK: - View Variables
extension PadsListView {
}


// MARK: - Private Helpers
private extension PadsListView {
}



// MARK: - Preview
struct PadsListView_Previews: PreviewProvider {

    static var previews: some View {
        let store = PreviewData.AppStores.withPads

        return PadsListView(
            viewModel: .init(padsState: store.state.padsState),
            buildDestination: { _ in EmptyView() }
        )
        .environmentObject(store)
    }
}
