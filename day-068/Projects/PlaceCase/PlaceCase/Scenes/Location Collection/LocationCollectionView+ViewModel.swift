//
//  LocationCollectionView.ViewModel.swif {
//  PlaceCase
//
//  Created by CypherPoet on 12/7/19.
// ✌️
//


import SwiftUI
import Combine
import CoreData
import CoreLocation


extension LocationCollectionView {
    
    final class ViewModel: NSObject, ObservableObject {
        private var subscriptions = Set<AnyCancellable>()
        private let locationManager = CLLocationManager()
        
        enum AlertState {
            case noAlert
            case currentLocationDisabled
            case locationSelected
            case currentLocationReadingFailed
        }
        
        
        @ObservedObject var collection: LocationCollection
        
        
        // MARK: - Published Outputs
        @Published var locations: [Location] = []
        @Published var selectedLocation: Location? = nil

        // ⚠️ Trying to pass this down to another view as a binding causes
        // that binding to get separated when this viewModel re-initializes.
//        @Published var centerCoordinate = CLLocationCoordinate2D()

        @Published var canReadCurrentLocation = false
        @Published var userLocationCoordinate: CLLocationCoordinate2D? = nil
        @Published var isShowingAlert = false
        @Published var isShowingEditView = false
        @Published var currentAlertState: AlertState = .noAlert
        
        
        // MARK: - Init
        init(collection: LocationCollection) {
            self.collection = collection
            
            super.init()
            
            setupSubscribers()
            
            self.fetchedResultsController.delegate = self
            fetchLocations()
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
}


// MARK: - Publishers
extension LocationCollectionView.ViewModel  {
    
    private var isShowingAlertPublisher: AnyPublisher<Bool, Never> {
        $currentAlertState
            .map { alertState in alertState != .noAlert }
            .print("isShowingAlertPublisher")
            .eraseToAnyPublisher()
    }
}


// MARK: - Computeds
extension LocationCollectionView.ViewModel  {
    var locationAuthStatus: CLAuthorizationStatus { CLLocationManager.authorizationStatus() }
    
    var selectedLocationAlertTitle: String { selectedLocation?.title ?? "Undisclosed Location" }

    var selectedLocationAlertMessage: String {
        selectedLocation?.longDescription ?? "No description has been provided yet."
    }
}


// MARK: - Public Methods
extension LocationCollectionView.ViewModel  {
    
    func fetchLocations() {
        // TODO: Better error handling here?
        try? fetchedResultsController.performFetch()
        setLocations(from: fetchedResultsController)
    }
    
    
    // TODO: Could this functionality live in a separate ObservableObject?
    // Perhaps it might also lend itself to a `LocationReading` protocol
    func requestLocationTrackingAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    
    func activateLocationManager() {
        switch locationAuthStatus {
        case .notDetermined:
            requestLocationTrackingAuthorization()
        case .denied, .restricted:
            self.currentAlertState = .currentLocationDisabled
        case .authorizedAlways, .authorizedWhenInUse:
            startUpdatingLocation()
        @unknown default:
            requestLocationTrackingAuthorization()
        }
    }
}


// MARK: - NSFetchedResultsControllerDelegate
extension LocationCollectionView.ViewModel: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let controller = controller as? NSFetchedResultsController<Location> else { return }
        
        print("controllerDidChangeContent")
        setLocations(from: controller)
    }
}


// MARK: - CLLocationManagerDelegate
extension LocationCollectionView.ViewModel: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocationCoordinate = locations.last?.coordinate else { return }
        
        userLocationCoordinate = currentLocationCoordinate
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // TODO: Better handling here
        print("locationManager::didFailWithError: \(error.localizedDescription)")
        
        currentAlertState = .currentLocationReadingFailed
    }
}


// MARK: - Private Helpers
private extension LocationCollectionView.ViewModel  {
    
    func setLocations(from fetchedResultsController: NSFetchedResultsController<Location>) {
        guard
            let section = fetchedResultsController.sections?.first,
            let fetchedLocations = section.objects as? [Location]
            else {
                locations = []
                return
        }
        print("setLocations || Count: \(fetchedLocations.count)")
        locations = fetchedLocations
    }
    
    
    func startUpdatingLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        
        locationManager.requestLocation()
    }
    
    
    func setupSubscribers() {
        isShowingAlertPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.isShowingAlert, on: self)
            .store(in: &subscriptions)
    }
}

