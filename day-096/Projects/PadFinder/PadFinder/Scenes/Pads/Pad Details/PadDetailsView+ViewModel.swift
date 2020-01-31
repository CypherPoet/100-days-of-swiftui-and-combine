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
        @Environment(\.horizontalSizeClass) var horizontalSizeClass
        @Environment(\.verticalSizeClass) var verticalSizeClass

        private var subscriptions = Set<AnyCancellable>()

        let pad: Pad
        let isPadFavorited: Bool
        private let snapshotService: MapSnapshotServicing
        

        // MARK: - Published Outputs
        @Published var mapSnapshotImage: UIImage?

        
        // MARK: - Init
        init(
            pad: Pad,
            isPadFavorited: Bool,
            snapshotService: MapSnapshotServicing
        ) {
            self.pad = pad
            self.isPadFavorited = isPadFavorited
            self.snapshotService = snapshotService
            
//             TODO: Implement snapshot caching, then retrieve it or take a new one here
//            let imageLength = max(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
            
            self.takeMapSnapshot(
                size: CGSize(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height * self.snapshotHeightRatio
                )
            )
            setupSubscribers()
        }
    }
}


// MARK: - Publishers
extension PadDetailsView.ViewModel {
}


// MARK: - Computeds
extension PadDetailsView.ViewModel {
    
    private var snapshotHeightRatio: CGFloat {
        horizontalSizeClass == .compact ? 0.35 : 0.60
    }
    
    var padNameText: String { pad.name }
    
    var latitudeText: String {
        NumberFormatters.padCoordinateDisplay.string(for: pad.latitude) ?? ""
    }

    var longitudeText: String {
        NumberFormatters.padCoordinateDisplay.string(for: pad.longitude) ?? ""
    }
    
    var wikipediaURL: URL? { pad.wikiURL }
    
    
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
    
    
    var favoritesButtonText: String {
        return isPadFavorited ? "Remove From Favorites" : "Add to Favorites"
    }
}


// MARK: - Public Methods
extension PadDetailsView.ViewModel {
    
    func takeMapSnapshot(size: CGSize) {
        let cacheKey = pad.snapshotCacheKey(from: size)
        
        if let cachedSnapshot = snapshotService.snapshotFromCache(key: cacheKey) {
            mapSnapshotImage = cachedSnapshot.image
        } else {
            snapshotService
                .takeSnapshot(cacheKey: cacheKey, size: size, coordinate: pad.coordinate)
                .assertNoFailure()
//                .print("takeMapSnapshot")
                .map(\.image)
                .receive(on: DispatchQueue.main)
                .sink(
                    receiveValue: { self.mapSnapshotImage = $0 }
            )
                .store(in: &subscriptions)
        }
    }
}



// MARK: - Private Helpers
private extension PadDetailsView.ViewModel {

    /// Strips the leading "sub domain" and trailing "top-level domain"
    /// parts (including the ".") from a URL `host` string
    func strippedHostName(from hostNameString: String) -> String {
        var hostNameString = hostNameString
        
        // Strip the leading sub domain part if it exists
        if hostNameString.split(separator: ".").count > 2 {
            hostNameString = hostNameString
                .replacingOccurrences(of: "^(\\w*\\.){1}", with: "", options: .regularExpression)
        }

        // Strip the trailing top-level domain part
        return hostNameString
            .replacingOccurrences(of: "\\.(.*)", with: "", options: .regularExpression)
            .capitalized
    }
    
    
    func setupSubscribers() {
    }
}
