//
//  ContactsContainerView+ViewModel.swift
//  QRConnections
//
//  Created by CypherPoet on 1/9/20.
// ✌️
//


import SwiftUI
import Combine



extension ContactsContainerView {
    final class ViewModel: ObservableObject {
        private var subscriptions = Set<AnyCancellable>()


        // MARK: - Published Properties
        @Published var filterState: Contact.FilterState = .all
        @Published var sortingState: Contact.SortingState = .byName
    }
}


// MARK: - Publishers
extension ContactsContainerView.ViewModel {}


// MARK: - Computeds
extension ContactsContainerView.ViewModel {
}


// MARK: - Public Methods
extension ContactsContainerView.ViewModel {
}



// MARK: - Private Helpers
private extension ContactsContainerView.ViewModel {
}
