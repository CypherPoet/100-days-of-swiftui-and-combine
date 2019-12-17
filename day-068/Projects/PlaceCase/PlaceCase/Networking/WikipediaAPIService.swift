//
//  WikipediaAPIService.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/13/19.
// ✌️
//

import SwiftUI
import Combine
import CoreData
import CypherPoetNetStack
import CypherPoetCoreDataKit


public final class WikipediaAPIService: ModelTransportRequestPublishing {
    public let session: URLSession
    private let apiQueue: DispatchQueue
    
    
    public init(
        session: URLSession = .shared,
        queue: DispatchQueue = .global(qos: .userInitiated)
    ) {
        self.session = session
        self.apiQueue = queue
    }
    

    private func pagesResult(
        near location: Location,
        decoder: JSONDecoder
    ) -> AnyPublisher<WikiPagesResult, NetStackError> {
        let endpoint = Endpoint.WikipediaAPI.wikiPages(near: location)

        guard let url = endpoint.url else {
            preconditionFailure("No URL could be made for location")
        }
        
        print("Fetching pages at url: \(url.absoluteString)")
        
        return perform(
            URLRequest(url: url),
            parsingResponseOn: apiQueue,
            with: decoder
        )
            .eraseToAnyPublisher()
    }
    
    
    func pages(
        near location: Location,
        usingContext context: NSManagedObjectContext,
        decoder: JSONDecoder = WikiPage.decoder
    ) -> AnyPublisher<[WikiPage], NetStackError> {
        
        decoder.userInfo[.managedObjectContext] = context
        
        return pagesResult(near: location, decoder: decoder)
            .map(\WikiPagesResult.query?.pages?.values)
            .map { dictionaryValues in
                guard let values = dictionaryValues else { return [] }
                
                return Array(values)
            }
            
//            // If the returned data didn't contain the keys that our decoder is already
//            // configured to check, return an empty array instead of an error.
//            .tryCatch { (error: NetStackError) -> AnyPublisher<[WikiPage], Never> in
//                switch error {
//                case .dataDecodingFailed(let decodingError):
//                    switch decodingError {
//                    case .keyNotFound(_, _):
//                        return Just([WikiPage]()).eraseToAnyPublisher()
//                    default:
//                        throw error
//                    }
//                default:
//                    throw error
//                }
//            }
            .eraseToAnyPublisher()
    }
}
