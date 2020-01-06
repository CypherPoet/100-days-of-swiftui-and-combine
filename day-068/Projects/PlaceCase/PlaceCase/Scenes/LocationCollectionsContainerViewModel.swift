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
    @Published var authenticationError: AuthenticatingServiceError? = nil


    // MARK: - Init
    init(
        authService: AuthenticatingService
    ) {
        self.authService = authService
    }
}



// MARK: - Public Methods
extension LocationCollectionsContainerViewModel {
    
    func authenticate() {
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
                        DispatchQueue.main.async { [weak self] in
                            self?.authenticationError = error
                            self?.isAuthenticated = false
                         }
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
    
    
    static func destination(for locationCollection: LocationCollection) -> LocationCollectionView {
        let viewModel = LocationCollectionViewModel(collection: locationCollection)
        
        return .init(viewModel: viewModel)
    }
}


// MARK: - Computeds
extension LocationCollectionsContainerViewModel {
    
    var authenticationErrorAlertTitle: String { "Authentication Failed" }
    
    var authenticationErrorAlertBody: String {
        guard let error = authenticationError else { return "" }
        
        switch error {
        case .noBiometricsEnabled:
            return "No Biomentric authentication is enabled on this device."
        case .evaluationFailed(_):
            return "An error occured while attempting evaluation."
        }
    }
}



// MARK: - Private Helpers
private extension LocationCollectionsContainerViewModel {
}
