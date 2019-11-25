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
        
        return perform(
            URLRequest(url: url),
            parsingResponseOn: apiQueue,
            with: JSONDecoder()
        )
        .mapError { .network(error: $0) }
        .eraseToAnyPublisher()
    }
    
    
    func fetchPayload(for payloadID: Payload.ID) -> AnyPublisher<Payload, SpaceXAPIService.Error> {
        let endpoint = Endpoint.SpaceXAPI.payload(for: payloadID)
        
        guard let url = endpoint.url else {
            preconditionFailure("Unable to make url for endpoint")
        }
        
        print("Fetching payload at URL path: \(url.absoluteString)")
        
        return perform(
            URLRequest(url: url),
            parsingResponseOn: apiQueue,
            with: Payload.decoder
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


extension SpaceXAPIService.Error {
    public var errorDescription: String? {
        switch self {
        case .network(let error):
            return error.errorDescription
        }
    }
}


// MARK: - Error: Identifiable
extension SpaceXAPIService.Error: Identifiable {
    public var id: String? { errorDescription }
}

