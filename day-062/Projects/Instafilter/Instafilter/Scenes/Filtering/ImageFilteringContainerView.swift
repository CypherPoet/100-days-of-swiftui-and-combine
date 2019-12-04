//
//  ImageFilteringContainerView.swift
//  Instafilter
//
//  Created by CypherPoet on 11/28/19.
// ✌️
//

import SwiftUI
import Combine

struct ImageFilteringContainerView: View {
    @EnvironmentObject var store: AppStore
    @ObservedObject private(set) var viewModel = ImageFilteringContainerViewModel()

    @State private var isShowingImagePicker = false
    @State private var isShowingWritingAuthError = false
}


// MARK: - Body
extension ImageFilteringContainerView {

    var body: some View {
        NavigationView {
            VStack(spacing: 42.0) {
                Group {
                    if viewModel.isShowingFilterView {
                        ImageFilteringView(
                            viewModel: viewModel.filteringViewModel,
                            onSave: save(filteredImage:)
                        )
                    } else {
                        Spacer()
                        
                        imageSelectionSection
                            .padding()
                        
                        Spacer()
                    }
                }
            }
            .navigationBarTitle(
                viewModel.isShowingFilterView ? "" : "📸 Instafilter",
                displayMode: viewModel.isShowingFilterView ? .inline : .large
            )
        }
        .onAppear { self.viewModel.store = self.store }
        .sheet(isPresented: $isShowingImagePicker) {
            UIImagePickerWrapper(onSelect: self.inputImageSelected(_:))
        }
        .alert(isPresented: $viewModel.isShowingErrorMessage) { self.errorAlert }
    }
}



// MARK: - Computeds
extension ImageFilteringContainerView {
    var filteredImagesState: FilteredImagesState { store.state.filteredImages }
    var filteredOutputCGImage: CGImage? { filteredImagesState.filteredOutputCGImage }
}


// MARK: - View Variables
extension ImageFilteringContainerView {
    
    private var imageSelectionSection: some View {
        VStack(spacing: 36) {
            Text("Select an Image to begin filtering.")
                .font(.title)
                .multilineTextAlignment(.center)
            
            imagePickerButton
        }
    }
    

    private var imagePickerButton: some View {
        Button(action: {
            self.isShowingImagePicker = true
        }) {
            Image(systemName: "camera.fill")
                .renderingMode(.original)
                .colorInvert()
                .scaleEffect(2)
        }
        .frame(minWidth: 80, minHeight: 40)
        .padding()
        .background(Color.accentColor)
        .cornerRadius(12)
        .shadow(color: .gray, radius: 8, x: 0, y: 0)
    }
    

    private var errorAlert: Alert {
        if viewModel.hasAuthError {
            return imageWritingAuthErrorAlert
        } else {
            return imageWritingErrorAlert
        }
    }
    
    
    private var imageWritingErrorAlert: Alert {
        Alert(
            title: Text("Failed to save image."),
            message: Text(self.viewModel.imageWritingErrorMessage),
            dismissButton: .default(Text("OK"))
        )
    }
    
    
    private var imageWritingAuthErrorAlert: Alert {
        Alert(
            title: Text("Unable to save images."),
            message: Text(self.viewModel.imageWritingAuthErrorMessage),
            dismissButton: .default(Text("OK"))
        )
    }
}


// MARK: - Private Helpers
private extension ImageFilteringContainerView {
    
    func save(filteredImage: CGImage) {
        if viewModel.hasImageWritingAuth {
            store.send(ImageWritingSideEffect.saveOutput(image: filteredImage))
        } else {
            viewModel.hasAuthError = true
        }
    }
    
    
    func inputImageSelected(_ image: UIImage) {
        viewModel.currentInputImage = image
    }
}


// MARK: - Preview
struct ImageFilteringContainerView_Previews: PreviewProvider {

    static var previews: some View {
        ImageFilteringContainerView()
            .environmentObject(SampleStore.default)
    }
}
