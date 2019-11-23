//
//  SpaceXAPIService.swift
//  SpaceXPayloadStats
//
//  Created by CypherPoet on 11/23/19.
// ✌️
//

import Foundation
import Combine
import CypherPoetNetStack


public final class SpaceXAPIService: ModelTransportRequestPublishing {
    public let session: URLSession
    private let apiQueue: DispatchQueue
    
    
    public init(
        session: URLSession = .shared,
        queue: DispatchQueue = .global(qos: .userInitiated)
    ) {
        self.session = session
        self.apiQueue = queue
    }
}


// MARK: - Core Methods
extension SpaceXAPIService {
    
    func fetchMissions() -> AnyPublisher<[Mission], SpaceXAPIService.Error> {
        let endpoint = Endpoint.SpaceXAPI.missions
        
        guard let url = endpoint.url else {
            preconditionFailure("Unable to make url for endpoint")
        }
        
        return self.perform(
            URLRequest(url: url),
            parsingResponseOn: apiQueue,
            with: JSONDecoder()
        )
        .mapError { .network(error: $0) }
        .eraseToAnyPublisher()
    }
}



// MARK: - Error
extension SpaceXAPIService {
    
    public enum Error: LocalizedError {
        case network(error: NetStackError)
    }
}


// MARK: - Error: Identifiable
extension SpaceXAPIService.Error: Identifiable {
    public var id: String? { errorDescription }
}
