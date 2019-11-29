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

    private var filteringService = ImageFilteringService.shared

    @Published var inputImage: UIImage
    @Published var currentFilter: CIFilter
    
    
    // MARK: - Published Properties
    @Published var filteredImage: Image?
    @Published var filteringErrorMessage: String?
    
    
    
    // MARK: - Init
    init(inputImage: UIImage) {
        self.inputImage = inputImage
        self.currentFilter = .sepiaTone()
        
        setupSubscribers()
    }
}


// MARK: - Publishers
extension ImageFilteringViewModel {

    private var filteredImagePublisher: AnyPublisher<Image, ImageFilteringService.Error> {
        $inputImage
            .print("filteredImagePublisher")
            .compactMap { $0 }
            .setFailureType(to: ImageFilteringService.Error.self)
            .map { inputImage in
                self.filteringService.apply(self.currentFilter, to: inputImage)
            }
            .switchToLatest()
            .map { cgImage in
                print("filteredImagePublisher mapping cgImage")
                return Image(uiImage: UIImage(cgImage: cgImage))
            }
//            .catch { error in
//                switch error {
//                case .cgImage(let message),
//                     .ciImage(let message),
//                     .filtering(let message):
//                    self.filteringErrorMessage = message
//                }
//
//                return Just(nil).eraseToAnyPublisher()
//            }
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
//            .handleEvents(receiveCompletion: { completion in
//                switch completion {
//                case .failure(let error):
//                    print("filteredImagePublisher error")
//                    switch error {
//                    case .cgImage(let message),
//                         .ciImage(let message),
//                         .filtering(let message):
//                        self.filteringErrorMessage = message
//                    }
//                case .finished:
//                    print("filteredImagePublisher finished")
//                }
//            })
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
                receiveValue: { self.filteredImage = $0 }
            )
            .store(in: &subscriptions)
        
        
        
//        filteredImagePublisher
//            .replaceError(with: nil)
//            .compactMap( { $0 })
//            .receive(on: DispatchQueue.main)
//            .assign(to: \.filteredImage, on: self)
//            .store(in: &subscriptions)
    }
}
