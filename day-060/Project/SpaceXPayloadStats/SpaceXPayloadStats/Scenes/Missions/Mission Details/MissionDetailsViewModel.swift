//
//  MissionDetailsViewModel.swift
//  SpaceXPayloadStats
//
//  Created by CypherPoet on 11/25/19.
// ✌️
//

import SwiftUI
import CoreData
import Combine


final class MissionDetailsViewModel: NSObject, ObservableObject {
    let mission: Mission

    
    @Published var payloads: [Payload] = []

    
    init(mission: Mission) {
        self.mission = mission
        super.init()
        
        self.fetchedResultsController.delegate = self

        fetchPayloads()
    }
    
    
    lazy var fetchRequest: NSFetchRequest<Payload> = {
        Payload.fetchRequest(for: mission)
    }()
    
    
    lazy var fetchedResultsController: NSFetchedResultsController<Payload> = {
        NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: CoreDataManager.shared.mainContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
    }()
}


// MARK: - Computeds
extension MissionDetailsViewModel {
    var hasPayloads: Bool { !payloadIDs.isEmpty }
    var hasWebLinks: Bool { !webLinks.isEmpty }
    
    var payloadIDs: [String] { mission.payloadIDs ?? [] }
    

    var webLinks: [(linkName: String, url: URL)] {
        [
            ("Website", mission.wikipediaURLString),
            ("Wikipedia", mission.twitterURLString),
            ("Twitter", mission.websiteURLString),
        ].compactMap { labelAndURLStringPair in
            guard
                let urlString = labelAndURLStringPair.1,
                let url = URL(string: urlString)
            else { return nil }

            return (labelAndURLStringPair.0, url)
        }
    }
    
    var missionName: String { mission.name ?? "" }
    var missionDescription: String { mission.missionDescription ?? "" }
}


// MARK: - Public Methods
extension MissionDetailsViewModel {
    
    func fetchPayloads() {
        // TODO: Better error handling here?
        try? fetchedResultsController.performFetch()
        setPayloads(from: fetchedResultsController)
    }
}


// MARK: - NSFetchedResultsControllerDelegate
extension MissionDetailsViewModel: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let controller = controller as? NSFetchedResultsController<Payload> else { return }
        
        setPayloads(from: controller)
    }
}


// MARK: - Private Helpers
private extension MissionDetailsViewModel {
    
    func setPayloads(from fetchedResultsController: NSFetchedResultsController<Payload>) {
        guard
            let section = fetchedResultsController.sections?.first,
            let fetchedPayloads = section.objects as? [Payload]
        else {
            payloads = []
            return
        }
        
        payloads = fetchedPayloads
    }
}


