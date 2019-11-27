//
//  SpaceXAPIService.swift
//  SpaceXPayloadStats
//
//  Created by CypherPoet on 11/23/19.
// ✌️
//

import Foundation
import Combine
import CoreData
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
    
    func fetchMissions(using context: NSManagedObjectContext) -> AnyPublisher<[Mission], SpaceXAPIService.Error> {
        guard let url = Endpoint.SpaceXAPI.missions.url else {
            preconditionFailure("Unable to make url for endpoint")
        }
        
        let decoder = Mission.decoder
        decoder.userInfo[.managedObjectContext] = context
        
        print("Fetching missions at URL path: \(url.absoluteString)")

        return perform(
            URLRequest(url: url),
            parsingResponseOn: apiQueue,
            with: decoder
        )
        .mapError { .network(error: $0) }
        .eraseToAnyPublisher()
    }
    
    
    func fetchPayload(
        for payloadID: String,
        using context: NSManagedObjectContext
    ) -> AnyPublisher<Payload, SpaceXAPIService.Error> {
        guard let url = Endpoint.SpaceXAPI.payload(for: payloadID).url else {
            preconditionFailure("Unable to make url for endpoint")
        }
        
        let decoder = Payload.decoder
        decoder.userInfo[.managedObjectContext] = context
        
        print("Fetching payload at URL path: \(url.absoluteString)")
        
        return perform(
            URLRequest(url: url),
            parsingResponseOn: apiQueue,
            with: decoder
        )
        .mapError { .network(error: $0) }
        .eraseToAnyPublisher()
    }
    

    func mergedPayloads(
        for payloadIDs: [String],
        using context: NSManagedObjectContext
    ) -> AnyPublisher<Payload, SpaceXAPIService.Error> {
        Publishers.MergeMany(payloadIDs.map { fetchPayload(for: $0, using: context) })
            .eraseToAnyPublisher()
    }
        
    
    func fetchPayloads(
        with payloadIDs: [String],
        using context: NSManagedObjectContext
    ) -> AnyPublisher<[Payload], SpaceXAPIService.Error> {
        mergedPayloads(for: payloadIDs, using: context)
            .scan([], { (accumulated, payload) -> [Payload] in
                accumulated + [payload]
            })
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

