//
//  ContactsListView+ViewModel.swift
//  QRConnections
//
//  Created by CypherPoet on 1/15/20.
// ✌️
//


import SwiftUI
import Combine
import UserNotifications


extension ContactsListView {
    final class ViewModel: ObservableObject {
        private var subscriptions = Set<AnyCancellable>()

        // MARK: - Published Outputs
        @Published var someValue: String = ""
        

        // MARK: - Init
        init() {
            setupSubscribers()
        }
    }
}


// MARK: - Publishers
extension ContactsListView.ViewModel {
}


// MARK: - Computeds
extension ContactsListView.ViewModel {
}


// MARK: - Public Methods
extension ContactsListView.ViewModel {
    
    
    func scheduleNotification(for contact: Contact) {
        CurrentApp.userNotificationsService.authorizationStatusPublisher
            .map { status in
                switch status {
                case .notDetermined:
                    CurrentApp.userNotificationsService.requestAuthorization() { [weak self] result in
                        switch result {
                        case .success(let wasGranted):
                            if wasGranted {
                                self?.scheduleNotification(for: contact)
                            } else {
//                                self.isShowingNotificationsAlert = true
                            }
                        case .failure:
//                            self.isShowingNotificationsAlert = true
                            break
                        }
                    }
                case .denied:
//                     self.isShowingNotificationsAlert = true
                    break
                case .authorized,
                     .provisional:
                    CurrentApp.userNotificationsService.add(
                        LocalNotifications.contactReminder(for: contact).request
                    ) { result in
                        if case .failure(let error) = result {
//                            self.isShowingNotificationsAlert = true
                        } else {
                            print("Notification scheduled")
                        }
                    }
                    break
                @unknown default:
                    fatalError()
                }
            }
            .sink(
                receiveCompletion: { (completion) in },
                receiveValue: { _ in }
            )
            .store(in: &subscriptions)
        
    }
    
}



// MARK: - Private Helpers
private extension ContactsListView.ViewModel {

    func setupSubscribers() {
//        someValuePublisher
//            .receive(on: DispatchQueue.main)
//            .assign(to: \.someValue, on: self)
//            .store(in: &subscriptions)
    }
}
