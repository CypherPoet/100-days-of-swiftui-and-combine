//
//  LaunchLibraryAPIServicing.swift
//  PadFinder
//
//  Created by CypherPoet on 1/26/20.
// ✌️
//

import Foundation
import Combine
import CypherPoetNetStack


protocol LaunchLibraryAPIServicing: ModelTransportRequestPublishing {
    func pads(using decoder: JSONDecoder) -> AnyPublisher<[Pad], Error>
}
