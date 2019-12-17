//
//  LocationCollectionViewModel.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/7/19.
// ✌️
//


import SwiftUI
import Combine
import CoreData


final class LocationCollectionViewModel: NSObject, ObservableObject {
    private var subscriptions = Set<AnyCancellable>()

    @ObservedObject var collection: LocationCollection
    

    // MARK: - Published Outputs
    @Published var locations: [Location] = []
    @Published var isShowingEditView: Bool = false
    
    @Published var isShowingSelectedLocationAlert: Bool = false {
        didSet {
            print("isShowingSelectedLocationAlert - didSet: \(isShowingSelectedLocationAlert)")
        }
    }
    
    
    // MARK: - Init
    init(collection: LocationCollection) {
        self.collection = collection
        
        super.init()
        
//        self.fetchedResultsController.delegate = self
//        fetchLocations()
    }
    
    
    lazy var fetchRequest: NSFetchRequest<Location> = {
        Location.fetchRequest(for: collection)
    }()
    
        
    lazy var fetchedResultsController: NSFetchedResultsController<Location> = {
        .init(
            fetchRequest: fetchRequest,
            managedObjectContext: CurrentApp.coreDataManager.mainContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
    }()
}


// MARK: - Publishers
extension LocationCollectionViewModel {
}


// MARK: - Computeds
extension LocationCollectionViewModel {
}


// MARK: - Public Methods
extension LocationCollectionViewModel {
    
    func fetchLocations() {
        // TODO: Better error handling here?
        try? fetchedResultsController.performFetch()
        setLocations(from: fetchedResultsController)
    }
}


// MARK: - NSFetchedResultsControllerDelegate
extension LocationCollectionViewModel: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let controller = controller as? NSFetchedResultsController<Location> else { return }
        
        setLocations(from: controller)
    }
}



// MARK: - Private Helpers
private extension LocationCollectionViewModel {

    func setLocations(from fetchedResultsController: NSFetchedResultsController<Location>) {
        guard
            let section = fetchedResultsController.sections?.first,
            let fetchedLocations = section.objects as? [Location]
        else {
            locations = []
            return
        }
        
        locations = fetchedLocations
    }
}
