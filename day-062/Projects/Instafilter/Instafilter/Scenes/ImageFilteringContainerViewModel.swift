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
    
    var store: AppStore? {
        didSet {
            guard store != nil else { return }
            self.setupSubscribers()
        }
    }

    
    // MARK: - Published Properties
    @Published var hasImageWritingAuth = false
    @Published var hasImageWritingError = false
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


// MARK: - Public Methods
extension ImageFilteringContainerViewModel {
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
    }
}
