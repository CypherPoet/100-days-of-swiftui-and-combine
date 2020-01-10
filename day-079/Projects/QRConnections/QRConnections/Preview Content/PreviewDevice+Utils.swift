//
//  PreviewProvider+Utils.swift
//  QRConnections
//
//  Created by CypherPoet on 1/10/20.
// ✌️
//

import Foundation
import SwiftUI


extension PreviewDevice {
    
    public struct ApplicationSupportText: View {
        @State private var path: String = ""
        
        public var body: some View {
            Text(path)
                .onAppear {
                    self.path = NSSearchPathForDirectoriesInDomains(
                        FileManager.SearchPathDirectory.applicationSupportDirectory,
                        .userDomainMask,
                        true
                    ).first!
            }
        }
    }
}
