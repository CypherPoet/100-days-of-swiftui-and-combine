//
//  ImageFilteringView.swift
//  Instafilter
//
//  Created by CypherPoet on 11/28/19.
// ✌️
//

import SwiftUI


struct ImageFilteringView: View {
    @ObservedObject private(set) var viewModel: ImageFilteringViewModel
    
    init(
        inputImage: UIImage,
        store: AppStore
    ) {
        self.viewModel = ImageFilteringViewModel(
            inputImage: inputImage,
            store: store
        )
    }
}


// MARK: - Body
extension ImageFilteringView {

    var body: some View {
        VStack {
            // TODO: Use an alert here instead
            if viewModel.filteringErrorMessage != nil {
                Text(viewModel.filteringErrorMessage!)
            }

            (viewModel.filteredImage ?? Image(uiImage: viewModel.inputImage))
                .resizable()
                .scaledToFit()
        }
    }
}


// MARK: - Computeds
extension ImageFilteringView {


}


// MARK: - View Variables
extension ImageFilteringView {


}



// MARK: - Preview
struct ImageFilteringView_Previews: PreviewProvider {

    static var previews: some View {
        ImageFilteringView(
            inputImage: UIImage(named: "earth-night")!,
            store: SampleStore.default
        )
    }
}
