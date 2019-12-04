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
    
    @State private var isShowingFilterSelectionSheet = false
    
    private let onSave: ((CGImage) -> Void)
    
    
    init(
        viewModel: ImageFilteringViewModel,
        onSave: @escaping ((CGImage) -> Void)
    ) {
        self.viewModel = viewModel
        self.onSave = onSave
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

            displayedImage?
                .resizable()
                .scaledToFit()
            
            Text(viewModel.currentFilter.name)
                .font(.title)
                .fontWeight(.light)
                .padding(.vertical)
            
            
            controls
                .padding()
            
            Spacer()
        }
        .sheet(isPresented: $isShowingFilterSelectionSheet) {
            FilterSelectionView(
                options: CoreImageFilter.allCases,
                onSelect: self.newFilterSelected(_:)
            )
        }
        .navigationBarItems(leading: swapFilterButton, trailing: saveButton)
    }
}


// MARK: - Computeds
extension ImageFilteringView {
    
    var outputImage: Image? {
        guard let cgImage = viewModel.processedImage else {
            return nil
        }

        return Image(cgImage, scale: 1, label: Text("Current Image"))
    }
    
    
    var displayedImage: Image? {
        if let outputImage = outputImage {
            return outputImage
        }
        
        if let inputImage = viewModel.inputImage {
            return Image(uiImage: inputImage)
        }
        
        return nil
    }
}


// MARK: - View Variables
extension ImageFilteringView {

    private var controls: some View {
        List {
            ForEach(viewModel.activeSliders, id: \.0) { slider in
                VStack(spacing: 2.0) {
                    Text(slider.displayName)
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    // Inspired by this solution for dynamically rendering controls inside
                    // of a `ForEach`: https://stackoverflow.com/a/56759097/8859365
                    FilterSlider(
                        viewModel: slider.viewModel,
                        labelText: slider.displayName
                    )
                }
                .padding(.vertical)
            }
        }
    }
    
    
    private var swapFilterButton: some View {
        Button(action: {
            self.isShowingFilterSelectionSheet = true
        }) {
            Image(systemName: "arrow.right.arrow.left")
            Text("Swap Filter")
        }
    }
    
    
    private var saveButton: some View {
        Button(action: {
            guard let outputImage = self.viewModel.processedImage else { fatalError() }
            self.onSave(outputImage)
        }) {
            Text("Save")
        }
        .disabled(self.viewModel.processedImage == nil)
    }
    
}


// MARK: - Private Helpers
private extension ImageFilteringView {
    
    func newFilterSelected(_ filterOption: CoreImageFilter) {
        guard let newFilter = CIFilter(name: filterOption.ciFilterName) else {
            fatalError("Unable to make CIFilter from name \"\(filterOption.ciFilterName)\"")
        }
        
        // Add a slight delay so we can see the new controls animate in after the sheet is dismissed
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.viewModel.currentFilter = newFilter
        }
    }
}




// MARK: - Preview
struct ImageFilteringView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            ImageFilteringView(
                viewModel: ImageFilteringViewModel(
                    inputImage: UIImage(named: "earth-night")!
                ),
                onSave: { _ in }
            )
            .environmentObject(SampleStore.default)
        }
    }
}


private struct FilterSlider: View {
    @ObservedObject var viewModel: ImageFilteringViewModel.SliderViewModel
    
    let labelText: String
    
    
    var body: some View {
       Slider(
            value: $viewModel.sliderValue
        ) {
            Text(labelText)
        }
    }
}
