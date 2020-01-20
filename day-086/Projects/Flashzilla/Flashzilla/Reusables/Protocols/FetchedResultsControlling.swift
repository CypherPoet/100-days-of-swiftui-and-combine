//
//  FetchedResultsControlling.swift
//  Flashzilla
//
//  Created by CypherPoet on 1/19/20.
// ✌️
//

import Foundation
import CoreData


public protocol FetchedResultsControlling: NSObject {
    associatedtype FetchedResult: NSFetchRequestResult
    
    var fetchRequest: NSFetchRequest<FetchedResult> { get }
    var fetchedResultsController: NSFetchedResultsController<FetchedResult> { get }
    
    func makeFetchedResultsController() -> FetchedResultsController
    func extractResults(from fetchedResultsController: FetchedResultsController) -> [FetchedResult]
}


extension FetchedResultsControlling {
    public typealias FetchedResultsController = NSFetchedResultsController<FetchedResult>
    public typealias FetchRequest = NSFetchRequest<FetchedResult>

    
    public func makeFetchedResultsController() -> FetchedResultsController {
        .init(
            fetchRequest: fetchRequest,
            managedObjectContext: CurrentApp.coreDataManager.mainContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
    }
    
    
    public func extractResults(from fetchedResultsController: FetchedResultsController) -> [FetchedResult] {
        guard
            let section = fetchedResultsController.sections?.first,
            let fetchedResults = section.objects as? [FetchedResult]
        else { return [] }
        
        return fetchedResults
    }
}

