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
    
    private enum SliderMultiplier {
        static let intensity: CGFloat = 1
        static let radius: CGFloat = 10
        static let scale: CGFloat = 200
    }

    
    lazy var intensitySliderViewModel = Self.SliderViewModel()
    lazy var radiusSliderViewModel = Self.SliderViewModel()
    lazy var scaleSliderViewModel = Self.SliderViewModel()
    
    
    lazy var supportedSliders: [(key: String, displayName: String, viewModel: SliderViewModel)] = [
        (kCIInputIntensityKey, "Intensity", intensitySliderViewModel),
        (kCIInputRadiusKey, "Radius", radiusSliderViewModel),
        (kCIInputScaleKey, "Scale", scaleSliderViewModel),
    ]
    
    
    @Published var inputImage: UIImage?
    @Published var currentFilter: CIFilter
    
    
    // MARK: - Published Outputs
    @Published var filteringErrorMessage: String?
    @Published var processedImage: CGImage?

    
    
    // MARK: - Init
    init(inputImage: UIImage? = nil) {
        self.inputImage = inputImage
        self.currentFilter = CIFilter(name: CoreImageFilter.sepiaTone.ciFilterName)!
        
        setupSubscribers()
    }
}


// MARK: - Publishers
extension ImageFilteringViewModel {
    
    // 📝 TODO: There's probably a good way to reduce some of the duplication here
    private var intensitySliderPublisher: AnyPublisher<(filterKey: String, value: CGFloat), Never> {
        intensitySliderViewModel.$sliderValue
            .dropFirst()
            .print("intensitySliderPublisher")
            .debounce(for: .milliseconds(200), scheduler: DispatchQueue.main)
            .map { (filterKey: kCIInputIntensityKey, value: $0 * SliderMultiplier.intensity) }
            .eraseToAnyPublisher()
    }
    
    private var radiusSliderPublisher: AnyPublisher<(filterKey: String, value: CGFloat), Never> {
        scaleSliderViewModel.$sliderValue
            .dropFirst()
            .debounce(for: .milliseconds(200), scheduler: DispatchQueue.main)
            .map { (filterKey: kCIInputRadiusKey, value: $0 * SliderMultiplier.radius) }
            .eraseToAnyPublisher()
    }
    
    private var scaleSliderPublisher: AnyPublisher<(filterKey: String, value: CGFloat), Never> {
        scaleSliderViewModel.$sliderValue
            .dropFirst()
            .debounce(for: .milliseconds(200), scheduler: DispatchQueue.main)
            .map { (filterKey: kCIInputScaleKey, value: $0 * SliderMultiplier.scale) }
            .eraseToAnyPublisher()
    }
    

    var ciFilterPublisher: AnyPublisher<CIFilter, Never> {
        Publishers.MergeMany(
            intensitySliderPublisher,
            scaleSliderPublisher,
            radiusSliderPublisher
        )
        .combineLatest($currentFilter)
        .map { (sliderKeyValuePair, currentFilter) in
            guard currentFilter.inputKeys.contains(sliderKeyValuePair.filterKey) else { return currentFilter }
            
            currentFilter.setValue(sliderKeyValuePair.value, forKey: sliderKeyValuePair.filterKey)
            
            return currentFilter
        }
        .eraseToAnyPublisher()
    }


    private var filteredCGImagePublisher: AnyPublisher<CGImage, ImageFilteringService.Error> {
        Publishers.CompactMap(upstream: self.$inputImage) { $0 }
            .combineLatest(ciFilterPublisher)
            .setFailureType(to: ImageFilteringService.Error.self)
            .flatMap { (image, filter) in
                ImageFilteringService.shared.apply(filter, to: image)
            }
            .eraseToAnyPublisher()
    }
}


// MARK: - Computeds
extension ImageFilteringViewModel {
    
    var activeSliders: [(key: String, displayName: String, viewModel: SliderViewModel)] {
        supportedSliders.filter {
            currentFilter.inputKeys.contains($0.key)
        }
    }
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
                    print("filteredImagePublisher, received value: \($0)")
                    self.processedImage = $0
                }
            )
            .store(in: &subscriptions)
    }
}


extension ImageFilteringViewModel {
    
    final class SliderViewModel: ObservableObject {
        @Published var sliderValue: CGFloat = 0.0
    }
}
