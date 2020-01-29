//
//  PadDetailsView+ViewModel.swift
//  PadFinder
//
//  Created by CypherPoet on 1/27/20.
// ✌️
//


import SwiftUI
import MapKit
import Combine


extension PadDetailsView {
    final class ViewModel: ObservableObject {
        private var subscriptions = Set<AnyCancellable>()

        private let pad: Pad
        private let snapshotService: MapSnapshotServicing
        

        // MARK: - Published Outputs
        @Published var mapSnapshotImage: UIImage?


        // MARK: - Init
        init(
            pad: Pad,
            snapshotService: MapSnapshotServicing
        ) {
            self.pad = pad
            self.snapshotService = snapshotService
            
            setupSubscribers()
        }
    }
}


// MARK: - Publishers
extension PadDetailsView.ViewModel {
}


// MARK: - Computeds
extension PadDetailsView.ViewModel {
    
    // TODO: Replace with MapKit Snapshot
    var mapImageName: String {
        "CanaveralMapSample"
    }
    
    var padNameText: String {
        pad.name
    }
    
    
    var latitudeText: String {
        NumberFormatters.padCoordinateDisplay.string(for: pad.latitude) ?? ""
    }

    var longitudeText: String {
        NumberFormatters.padCoordinateDisplay.string(for: pad.longitude) ?? ""
    }
    
    var wikipediaURL: URL? {
        pad.wikiURL
    }
    
    
    var webLinkData: [(hostName: String, url: URL)] {
        ([wikipediaURL] + (pad.infoURLs ?? [URL?]()))
            .compactMap { url in
                guard
                    let url = url,
                    let hostName = url.host
                else { return nil }
                
                return (hostName: strippedHostName(from: hostName), url: url)
            }
    }
}


// MARK: - Public Methods
extension PadDetailsView.ViewModel {
    
    func takeMapSnapshot(with size: CGSize) {
        snapshotService
            .takeSnapshot(with: size, at: pad.coordinate)
            .assertNoFailure()
            .print("takeMapSnapshot")
            .map(\.image)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveValue: { self.mapSnapshotImage = $0 }
            )
            .store(in: &subscriptions)
    }
}



// MARK: - Private Helpers
private extension PadDetailsView.ViewModel {

    func strippedHostName(from hostNameString: String) -> String {
        hostNameString
            .replacingOccurrences(of: "www.", with: "")
            .replacingOccurrences(of: "\\.(.*)", with: "", options: .regularExpression)
            .capitalized
    }
    
    
    func setupSubscribers() {
        
//        snapshotImagePublisher
//            .receive(on: DispatchQueue.main)
//            .sink(
//                receiveValue: { self.mapSnapshotImage = $0 }
//            )
//            .store(in: &subscriptions)
    }
}
