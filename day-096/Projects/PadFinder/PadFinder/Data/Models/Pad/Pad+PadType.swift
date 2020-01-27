//
//  Pad+PadType.swift
//  PadFinder
//
//  Created by CypherPoet on 1/27/20.
// ✌️
//

import Foundation
import SwiftUI


extension Pad {
    enum PadType: Int, Decodable {
        case launch = 0
        case landing = 1
    }
}

extension Pad.PadType: CaseIterable {}

extension Pad.PadType: Identifiable {
    var id: Int { self.rawValue }
}


extension Pad.PadType {
        
    var displayName: String {
        switch self {
        case .launch:
            return "Launch Pad"
        case .landing:
            return "Landing Pad"
        }
    }
    
    
    var sfSymbolName: String {
        switch self {
        case .launch:
            return "chevron.up"
        case .landing:
            return "chevron.down"
        }
    }
    
    
    var listItemBackgroundColor: Color {
        switch self {
        case .launch:
            return .purple
        case .landing:
            return .orange
        }
    }
    
    
    var listItemImage: some View {
        Image(systemName: sfSymbolName)
            .font(.title)
            .foregroundColor(.white)
            .padding(11)
            .background(listItemBackgroundColor)
            .clipShape(Circle())
    }
}
