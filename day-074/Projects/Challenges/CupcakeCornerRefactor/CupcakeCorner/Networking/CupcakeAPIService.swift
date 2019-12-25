//
//  CupcakeAPIService.swift
//  CupcakeCorner
//
//  Created by CypherPoet on 11/13/19.
// ✌️
//

import Foundation
import Combine
import NetStack


final class CupcakeAPIService: ModelTransportRequestPublishing {
    static let defaultQueue = DispatchQueue(label: "API Queue", qos: .userInitiated, attributes: [.concurrent])
    

    var session: URLSession
    var queue: DispatchQueue

    
    init(
        session: URLSession = .shared,
        queue: DispatchQueue = defaultQueue
    ) {
        self.session = session
        self.queue = queue
    }
    
    
    func save(_ order: Order) -> AnyPublisher<Order, Error> {
        guard let url = Endpoint.order.url else { fatalError() }
        
        return encode(dataFor: order, thenSendTo: url, parsingResponseOn: queue)
            .eraseToAnyPublisher()
    }
}


// MARK: - Error
extension CupcakeAPIService {
    public typealias Error = NetStackError
}


// MARK: - Error: Identifiable
extension CupcakeAPIService.Error: Identifiable {
    public var id: String? { errorDescription }
}
