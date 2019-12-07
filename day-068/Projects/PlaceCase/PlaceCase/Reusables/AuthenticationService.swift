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



protocol AuthenticatingService {
    
    /// - Parameter reason: The app-provided reason for requesting authentication,
    ///     which displays in the authentication dialog presented to the user.
    func authenticate(reason: String) -> AnyPublisher<Void, Error>
}



final class AuthenticationService: AuthenticatingService {
    static let authReason = "Please authenticate to unlock this app and access saved locations."
    
    enum Error: Swift.Error {
        case noBiometricsEnabled(Swift.Error?)
        case evaluationFailed(Swift.Error?)
    }
    
    
    private let laContextType: LAContextType.Type
    private var context: LAContextType?

    
    init(laContextType: LAContextType.Type) {
        self.laContextType = laContextType
    }
    
    
    func authenticate(reason: String) -> AnyPublisher<Void, Swift.Error> {
        let context = laContextType.init()
        self.context = context
        
        var error: NSError?
        
        guard context.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            error: &error
        ) else {
            defer { self.context = nil }
            
            return Fail(error: Error.noBiometricsEnabled(error))
                .eraseToAnyPublisher()
        }
        
        
        return Future { promise in
            context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: reason
            ) { (wasSuccessful, error) in
                defer { self.context = nil }
                
                guard wasSuccessful else {
                    promise(.failure(Error.evaluationFailed(error)))
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
        func authenticate(reason: String) -> AnyPublisher<Void, Error> {
            Empty().eraseToAnyPublisher()
        }
    }
}

#endif
