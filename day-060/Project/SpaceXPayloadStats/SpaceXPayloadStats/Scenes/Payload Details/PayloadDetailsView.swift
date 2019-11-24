//
//  PayloadDetailsView.swift
//  SpaceXPayloadStats
//
//  Created by CypherPoet on 11/23/19.
// ✌️
//

import SwiftUI


struct PayloadDetailsView: View {
    @ObservedObject private var viewModel: PayloadDetailsViewModel

    init(payloadID: Payload.ID, store: AppStore) {
        self.viewModel = PayloadDetailsViewModel(
            payloadID: payloadID,
            store: store
        )
    }
}


// MARK: - Body
extension PayloadDetailsView {

    var body: some View {
        VStack {
            Text(viewModel.payloadNameText)
        }
        .onAppear(perform: viewModel.loadPayload)
    }
}

// MARK: - Computeds
extension PayloadDetailsView {
}


// MARK: - View Variables
extension PayloadDetailsView {
}


// MARK: - Private Helpers
private extension PayloadDetailsView {
}



// MARK: - Preview
struct PayloadDetailsView_Previews: PreviewProvider {

    static var previews: some View {
        PayloadDetailsView(
            payloadID: SamplePayloads.telstar18V.id,
            store: SampleStore.withModels
        )
    }
}
