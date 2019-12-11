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
    private let collection: LocationCollection
    

    // MARK: - Published Outputs
    @Published var locations: [Location] = []
    @Published var selectedLocation: Location? = nil

    
    // MARK: - Init
    init(collection: LocationCollection) {
        self.collection = collection
        
        super.init()
        
        self.fetchedResultsController.delegate = self
        fetchLocations()
    }
    
    
    lazy var fetchRequest: NSFetchRequest<Location> = {
        Location.fetchRequest(for: collection)
    }()
    
        
    lazy var fetchedResultsController: NSFetchedResultsController<Location> = {
        .init(
            fetchRequest: fetchRequest,
            managedObjectContext: CoreDataManager.shared.mainContext,
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
    
    var selectedLocationAlertTitle: String {
        selectedLocation?.title ?? "Undisclosed Location"
    }
    
    var selectedLocationAlertMessage: String {
        selectedLocation?.subtitle ?? "No description has been provided yet."
    }
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

    func setupSubscribers() {
    }
    
    
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
