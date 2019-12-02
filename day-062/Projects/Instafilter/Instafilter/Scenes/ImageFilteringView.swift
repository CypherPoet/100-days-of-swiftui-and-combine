//
//  ImageFilteringView.swift
//  Instafilter
//
//  Created by CypherPoet on 11/28/19.
// ✌️
//

import SwiftUI


struct ImageFilteringView: View {
    @EnvironmentObject private var store: AppStore
    @ObservedObject private(set) var viewModel: ImageFilteringViewModel

    private let inputImage: UIImage
    
    
    init(
        inputImage: UIImage,
        store: AppStore
    ) {
        self.inputImage = inputImage
        
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

            (outputImage ?? Image(uiImage: inputImage))
                .resizable()
                .scaledToFit()
            
            controls
                .padding()
                .padding(.top)
            
            Spacer()
        }
    }
}


// MARK: - Computeds
extension ImageFilteringView {
    
    var outputImage: Image? {
        guard let cgImage = store.state.filteredImages.filteredOutputCGImage else {
            return nil
        }
        
        return Image(uiImage: UIImage(cgImage: cgImage))
    }

}


// MARK: - View Variables
extension ImageFilteringView {

    private var controls: some View {
        VStack(spacing: 24) {
            
            VStack(spacing: 2.0) {
                Text("Intensity")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Slider(
                    value: $viewModel.filterIntensity,
                    minimumValueLabel: Text("0"),
                    maximumValueLabel: Text("1")
                ) {
                    Text("Intensity")
                }
            }
        }
    }
}



// MARK: - Preview
struct ImageFilteringView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            ImageFilteringView(
                inputImage: UIImage(named: "earth-night")!,
                store: SampleStore.default
            )
            .environmentObject(SampleStore.default)
        }
    }
}
