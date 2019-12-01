//
//  ImageFilteringViewModel.swift
//  Instafilter
//
//  Created by CypherPoet on 11/28/19.
// ✌️
//


import SwiftUI
import Combine


final class ImageFilteringViewModel: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()

    private let filteringService = ImageFilteringService.shared
    private let store: AppStore

    @Published var inputImage: UIImage
    @Published var currentFilter: CIFilter
    
    
    // MARK: - Published Properties
    @Published var filteredImage: Image?
    @Published var filteringErrorMessage: String?
    
    
    
    // MARK: - Init
    init(
        inputImage: UIImage,
        store: AppStore
    ) {
        self.inputImage = inputImage
        self.store = store
        self.currentFilter = .sepiaTone()
        
        setupSubscribers()
    }
}


// MARK: - Publishers
extension ImageFilteringViewModel {

    private var filteredImagesStatePublisher: AnyPublisher<FilteredImagesState, Never> {
        store.$state
            .map(\.filteredImages)
            .eraseToAnyPublisher()
    }
  
    
    private var filteredCGImagePublisher: AnyPublisher<CGImage, Never> {
        filteredImagesStatePublisher
            .map(\.filteredOutputCGImage)
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
  
    
    private var filteredImagePublisher: AnyPublisher<Image?, Never> {
        filteredCGImagePublisher
            .map { cgImage in
                Image(uiImage: UIImage(cgImage: cgImage))
            }
            .eraseToAnyPublisher()
    }
}


// MARK: - Computeds
extension ImageFilteringViewModel {
}


// MARK: - Public Methods
extension ImageFilteringViewModel {
}



// MARK: - Private Helpers
private extension ImageFilteringViewModel {

    func setupSubscribers() {
        filteredImagePublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.filteredImage, on: self)
            .store(in: &subscriptions)
        
        
//        filteredImagePublisher
//            .receive(on: DispatchQueue.main)
//            .sink(
//                receiveCompletion: { completion in
//                    switch completion {
//                    case .failure(let error):
//                        print("filteredImagePublisher error")
//                        switch error {
//                        case .cgImage(let message),
//                             .ciImage(let message),
//                             .filtering(let message):
//                            self.filteringErrorMessage = message
//                        }
//                    case .finished:
//                        print("filteredImagePublisher finished")
//                    }
//                },
//                receiveValue: { self.filteredImage = $0 }
//            )
//            .store(in: &subscriptions)
    }
}
