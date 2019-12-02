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
    @Published var filterIntensity: CGFloat = 0.0
    
    
    // MARK: - Published Properties
//    @Published var filteredImage: Image?
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
    
    private var filterIntensityPublisher: AnyPublisher<CGFloat, Never> {
        $filterIntensity
            .debounce(for: .milliseconds(200), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
  
    
    // TODO: Should this create a copy and return it? Should this be used straight-on
    // instead of the other `currentFilter` property?
    var ciFilterPublisher: AnyPublisher<CIFilter, Never> {
//        Publishers.CombineLatest(filterIntensityPublisher, )
        filterIntensityPublisher
            .map {
                self.currentFilter.setValue($0, forKey: kCIInputIntensityKey)
                
                return self.currentFilter
            }
            .eraseToAnyPublisher()
    }


    private var filteredCGImagePublisher: AnyPublisher<CGImage, ImageFilteringService.Error> {
        ciFilterPublisher
            .setFailureType(to: ImageFilteringService.Error.self)
            .flatMap { filter in
                ImageFilteringService.shared.apply(filter, to: self.inputImage)
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

        filteredCGImagePublisher
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        print("filteredImagePublisher error")
                        switch error {
                        case .cgImage(let message),
                             .ciImage(let message),
                             .filtering(let message):
                            self.filteringErrorMessage = message
                        }
                    case .finished:
                        print("filteredImagePublisher finished")
                    }
                },
                receiveValue: {
                    self.store.send(.filteredImages(.setFilteredOutput(image: $0)))
                }
            )
            .store(in: &subscriptions)
    }
}
