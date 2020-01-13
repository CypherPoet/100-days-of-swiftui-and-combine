//
//  UserQRCodeFormView+ViewModel.swift
//  QRConnections
//
//  Created by CypherPoet on 1/13/20.
// ✌️
//


import SwiftUI
import Combine


extension UserQRCodeFormView {
    final class ViewModel: ObservableObject {
        private var subscriptions = Set<AnyCancellable>()
        private var userProfileState: UserProfileState

        
        // MARK: - Form Inputs
        @Published var userNameText: String = ""

        
        // MARK: - Published Outputs
        @Published var userName: String = ""
        @Published var qrCodeData = Data()


        // MARK: - Init
        init(
            userProfileState: UserProfileState
        ) {
            self.userProfileState = userProfileState
            self.userNameText = userProfileState.name
            
            setupSubscribers()
        }
    }
}


// MARK: - Publishers
extension UserQRCodeFormView.ViewModel {

    private var userProfileStatePublisher: Publishers.Share<AnyPublisher<UserProfileState, Never>> {
        CurrentValueSubject(userProfileState)
            .eraseToAnyPublisher()
            .share()
    }
    
    
    private var userNameTextPublisher: AnyPublisher<String, Never> {
        $userNameText
            .dropFirst(1)
            .debounce(for: .milliseconds(650), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    
    private var userNamePublisher: Publishers.Share<AnyPublisher<String, Never>> {
        userNameTextPublisher
            .share()
    }
    
    
    private var qrCodeDataPublisher: AnyPublisher<Data, Never> {
        userNamePublisher.share()
//            .print("qrCodeDataPublisher")
            .map { text in
                text
                    .appending(self.userProfileState.uuid.uuidString)
                    .data(using: .utf8)!
            }
            .eraseToAnyPublisher()
    }
}


// MARK: - Computeds
extension UserQRCodeFormView.ViewModel {}


// MARK: - Public Methods
extension UserQRCodeFormView.ViewModel {}



// MARK: - Private Helpers
private extension UserQRCodeFormView.ViewModel {
    func setupSubscribers() {
        qrCodeDataPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.qrCodeData, on: self)
            .store(in: &subscriptions)

        userNamePublisher
            .receive(on: DispatchQueue.main)
            .print("userNamePublisher - assigning")
            .assign(to: \.userName, on: self)
            .store(in: &subscriptions)
    }
}
