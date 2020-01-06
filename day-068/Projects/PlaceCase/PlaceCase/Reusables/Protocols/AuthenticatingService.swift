//
//  AuthenticatingService.swift
//  PlaceCase
//
//  Created by CypherPoet on 1/5/20.
// ✌️
//

import Combine


public enum AuthenticatingServiceError: Error, Identifiable {
    public var id: String { self.localizedDescription }

    case noBiometricsEnabled(Swift.Error?)
    case evaluationFailed(Swift.Error?)
}


public protocol AuthenticatingService {
    
    /// - Parameter reason: The app-provided reason for requesting authentication,
    ///     which displays in the authentication dialog presented to the user.
    func authenticate(reason: String) -> AnyPublisher<Void, AuthenticatingServiceError>
}

