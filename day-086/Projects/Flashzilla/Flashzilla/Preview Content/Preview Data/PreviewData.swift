//
//  PreviewData.swift
//  Flashzilla
//
//  Created by CypherPoet on 1/19/20.
// ✌️
//

import Foundation
import CoreData


enum PreviewData {
    
    static func setupSimulatorPreviewData(in managedObjectContext: NSManagedObjectContext) {
        let _ = PreviewData.Cards.buildDeck()
        
        try? managedObjectContext.save()
    }
}
