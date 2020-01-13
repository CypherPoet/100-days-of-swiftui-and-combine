//
//  UserQRCodeContainerView+ViewModel.swift
//  QRConnections
//
//  Created by CypherPoet on 1/13/20.
// ✌️
//


import SwiftUI
import Combine


extension UserQRCodeContainerView {
    final class ViewModel: ObservableObject {
        private var subscriptions = Set<AnyCancellable>()
        
        var userProfileState: UserProfileState
        
        
        // MARK: - Published Outputs
        @Published var qrCodeCGImage: CGImage?
        

        // MARK: - Init
        init(
            userProfileState: UserProfileState
        ) {
            self.userProfileState = userProfileState
            self.qrCodeCGImage = userProfileState.qrCodeCGImage
            
            setupSubscribers()
        }
    }
}


// MARK: - Publishers
extension UserQRCodeContainerView.ViewModel {

    private var userProfileStatePublisher: Publishers.Share<AnyPublisher<UserProfileState, Never>> {
        CurrentValueSubject(userProfileState)
            .eraseToAnyPublisher()
            .share()
    }
    
    private var qrCodeCGImagePublisher: AnyPublisher<CGImage?, Never> {
        userProfileStatePublisher
            .map(\.qrCodeCGImage)
            .eraseToAnyPublisher()
    }
}


// MARK: - Computeds
extension UserQRCodeContainerView.ViewModel {
}


// MARK: - Public Methods
extension UserQRCodeContainerView.ViewModel {
}



// MARK: - Private Helpers
private extension UserQRCodeContainerView.ViewModel {

    func setupSubscribers() {
        qrCodeCGImagePublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.qrCodeCGImage, on: self)
            .store(in: &subscriptions)
    }
}


