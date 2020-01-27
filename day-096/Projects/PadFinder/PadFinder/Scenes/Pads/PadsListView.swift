//
//  PadsListView.swift
//  PadFinder
//
//  Created by CypherPoet on 1/26/20.
// ✌️
//

import SwiftUI


struct PadsListView {
    @EnvironmentObject private var store: AppStore

    @ObservedObject var viewModel: ViewModel
}


// MARK: - View
extension PadsListView: View {

    var body: some View {
        List(viewModel.pads) { pad in
            NavigationLink(destination: Text(pad.name)) {
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
            viewModel: .init(padsState: store.state.padsState)
        )
        .environmentObject(store)
    }
}
