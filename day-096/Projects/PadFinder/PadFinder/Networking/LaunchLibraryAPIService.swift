//
//  LaunchLibraryAPIService.swift
//  PadFinder
//
//  Created by CypherPoet on 1/26/20.
// ✌️
//

import Foundation
import Combine
import CypherPoetNetStack


final class LaunchLibraryAPIService: LaunchLibraryAPIServicing {
    var session: URLSession
    var apiQueue: DispatchQueue
    
    
    init(
        session: URLSession = .shared,
        queue: DispatchQueue = DispatchQueue(label: "LaunchLibraryAPIService", qos: .userInitiated)
    ) {
        self.session = session
        self.apiQueue = queue
    }
}



extension LaunchLibraryAPIService {
    
    private func padsContainer(
        using decoder: JSONDecoder = Pad.decoder
    )  -> AnyPublisher<Pad.ResultsContainer, Swift.Error> {
        let endpoint = Endpoint.LaunchLibraryAPI.pads()

        guard let url = endpoint.url else {
            fatalError("Failed to make URL for pads.")
        }
        
        return perform(
            URLRequest(url: url),
            parsingResponseOn: apiQueue,
            with: decoder
        )
        .mapError { Error.network(error: $0) }
        .eraseToAnyPublisher()
    }
    
    
    func pads(
        using decoder: JSONDecoder = Pad.decoder
    ) -> AnyPublisher<[Pad], Swift.Error> {
        padsContainer(using: decoder)
            .map(\.pads)
            .eraseToAnyPublisher()
    }
}


// MARK: - Error
extension LaunchLibraryAPIService {
    
    enum Error: LocalizedError {
        case network(error: NetStackError)
    }
}


extension LaunchLibraryAPIService.Error {
    public var errorDescription: String? {
        switch self {
        case .network(let error):
            return error.errorDescription
        }
    }
}


// MARK: - Error: Identifiable
extension LaunchLibraryAPIService.Error: Identifiable {
    public var id: String? { errorDescription }
}
