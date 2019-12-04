//
//  ImageFilteringContainerViewModel.swift
//  Instafilter
//
//  Created by CypherPoet on 11/30/19.
// ✌️
//


import SwiftUI
import Combine


final class ImageFilteringContainerViewModel: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()

    // 🔑 It's important to initialize this outisde of the view `body` so that it doesn't
    // get cleaned up every time the aforementioned `body` gets re-rendered.
    var filteringViewModel = ImageFilteringViewModel()
    
    var store: AppStore? {
        didSet {
            guard store != nil else { return }
            self.setupSubscribers()
        }
    }

    
    @Published var hasAuthError = false
    @Published var hasImageWritingError = false
    
    @Published var currentInputImage: UIImage? {
        didSet {
            filteringViewModel.inputImage = currentInputImage
        }
    }


    // MARK: - Published Outputs
    @Published var hasImageWritingAuth = false
    @Published var isShowingErrorMessage = false
    @Published var isShowingFilterView = false
}


// MARK: - Publishers
extension ImageFilteringContainerViewModel {

    private var imageWritingStatePublisher: AnyPublisher<ImageWritingState, Never>? {
        store?.$state
            .map(\.imageWriting)
            .eraseToAnyPublisher()
    }
    
    private var hasImageWritingErrorPublisher: AnyPublisher<Bool, Never>? {
        imageWritingStatePublisher?
            .map { $0.writingError != nil }
            .eraseToAnyPublisher()
    }
    
    private var isShowingFilteringViewPublisher: AnyPublisher<Bool, Never> {
        $currentInputImage
            .print("isShowingFilteringViewPublisher")
            .map { $0 != nil }
            .eraseToAnyPublisher()
    }
    
    private var isShowingErrorMessagePublisher: AnyPublisher<Bool, Never> {
        Publishers.Merge(
            $hasAuthError,
            $hasImageWritingError
        )
        .eraseToAnyPublisher()
    }
}


// MARK: - Computeds
extension ImageFilteringContainerViewModel {
    
    var imageWritingAuthErrorMessage: String {
        guard !hasImageWritingAuth else { return "" }
        
        return """
        This app doesn't have permission to write images to your Photos album.
        You can grant permission from within the Settings app.
        """
    }
    
    
    var imageWritingErrorMessage: String {
        guard !hasImageWritingError else { return "" }

        return "Image writing operation failed."
    }
}


// MARK: - Private Helpers
private extension ImageFilteringContainerViewModel {

    func setupSubscribers() {
        ImageWriter.isAuthorized
            .receive(on: DispatchQueue.main)
            .assign(to: \.hasImageWritingAuth, on: self)
            .store(in: &subscriptions)
        
        
        hasImageWritingErrorPublisher?
            .receive(on: DispatchQueue.main)
            .assign(to: \.hasImageWritingError, on: self)
            .store(in: &subscriptions)
        
        
        isShowingFilteringViewPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.isShowingFilterView, on: self)
            .store(in: &subscriptions)
        
        
        isShowingErrorMessagePublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.isShowingErrorMessage, on: self)
            .store(in: &subscriptions)
    }
}
