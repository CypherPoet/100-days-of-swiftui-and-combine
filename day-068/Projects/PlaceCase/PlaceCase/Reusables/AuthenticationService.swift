//
//  AuthenticationService.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/7/19.
// ✌️
//

import SwiftUI
import Combine
import LocalAuthentication


/// Protocol describing some core functionality of the `LAContext` class
protocol LAContextType {
    init()
    
    func canEvaluatePolicy(_ policy: LAPolicy, error: NSErrorPointer) -> Bool
    func evaluatePolicy(_ policy: LAPolicy, localizedReason: String, reply: @escaping (Bool, Error?) -> Void)

}

extension LAContext: LAContextType {}



class AuthenticationService: AuthenticatingService {
    static let authReason = "Please authenticate to unlock this app and access saved locations."

    private let laContextType: LAContextType.Type
    private var context: LAContextType?

    
    init(laContextType: LAContextType.Type = LAContext.self) {
        self.laContextType = laContextType
    }
    
    
    /// - Parameter reason: The app-provided reason for requesting authentication,
    ///     which displays in the authentication dialog presented to the user.
    func authenticate(reason: String) -> AnyPublisher<Void, AuthenticatingServiceError> {
        let context = laContextType.init()
        self.context = context
        
        var error: NSError?
        
        guard context.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            error: &error
        ) else {
            defer { self.context = nil }
            
            return Fail(error: .noBiometricsEnabled(error))
                .eraseToAnyPublisher()
        }
        
        
        return Future { promise in
            context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: reason
            ) { (wasSuccessful, error) in
                defer { self.context = nil }
                
                guard wasSuccessful else {
                    promise(.failure(.evaluationFailed(error)))
                    return
                }
                
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
        
        
    }
}


#if DEBUG

extension SampleData {
    
    class AuthService: AuthenticatingService {
        func authenticate(reason: String) -> AnyPublisher<Void, AuthenticatingServiceError> {
            Empty().eraseToAnyPublisher()
        }
    }
}

#endif
