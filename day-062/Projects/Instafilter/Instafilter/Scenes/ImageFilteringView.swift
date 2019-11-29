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
    
//    @ObservedObject private(set) var viewModel = ImageFilteringViewModel()

    init(inputImage: UIImage) {
        self.viewModel = ImageFilteringViewModel(inputImage: inputImage)
    }
}


// MARK: - Body
extension ImageFilteringView {

    var body: some View {
        VStack {
            if viewModel.filteringErrorMessage != nil {
                Text(viewModel.filteringErrorMessage!)
            }

            viewModel.filteredImage?
                .resizable()
                .scaledToFit()
        }
//        .onAppear {
//            self.viewModel.inputImage = UIImage(named: "earth-night")
//        }
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
            inputImage: UIImage(named: "earth-night")!
        )
    }
}
