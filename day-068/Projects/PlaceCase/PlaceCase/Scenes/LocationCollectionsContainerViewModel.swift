//
//  LocationCollectionsContainerViewModel.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/8/19.
// ✌️
//


import SwiftUI
import Combine


final class LocationCollectionsContainerViewModel: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()

    private let authService: AuthenticatingService
    

    // MARK: - Published Properties
    @Published var isAuthenticated: Bool = false


    // MARK: - Init
    init(
        authService: AuthenticatingService
    ) {
        self.authService = authService
        
        setupSubscribers()
    }
}



// MARK: - Public Methods
extension LocationCollectionsContainerViewModel {
    
    func onAppear() {
        authService
            .authenticate(reason: AuthenticationService.authReason)
            
            // 📝 Attempting to use `receive(on:)` here will cause the event to be dropped.
            // This appears to be a bug: https://forums.swift.org/t/combine-receive-on-runloop-main-loses-sent-value-how-can-i-make-it-work/28631/47
            //
//            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        print("Authentication failed: \(error)")
                        self.isAuthenticated = false
                    default:
                        print("Authentication completed")
                    }
                },
                receiveValue: {
                    print("Authentication value received")
                    DispatchQueue.main.async { [weak self] in
                        self?.isAuthenticated = true
                    }
                }
            )
            .store(in: &subscriptions)
    }
}



// MARK: - Private Helpers
private extension LocationCollectionsContainerViewModel {

    func setupSubscribers() {
    }
}
