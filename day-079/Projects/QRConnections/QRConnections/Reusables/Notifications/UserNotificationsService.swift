//
//  UserNotificationsService.swift
//  QRConnections
//
//  Created by CypherPoet on 1/16/20.
// ✌️
//

import Foundation
import UserNotifications
import Combine


protocol UserNotificationsServiceable: class {
    var subscriptions: Set<AnyCancellable> { get set }
    var notificationCenter: UNUserNotificationCenter { get }
    
    var notificationsSettingsPublisher: Publishers.Share<AnyPublisher<UNNotificationSettings, Never>> { get }
    var authorizationStatusPublisher: Publishers.Share<AnyPublisher<UNAuthorizationStatus, Never>> { get }
    
    func getNotificationSettings() -> Future<UNNotificationSettings, Never>
    
    func requestAuthorization(
        withAbilities authorizationOptions: UNAuthorizationOptions,
        then completionHandler: ((Result<Bool, Error>) -> Void)?
    )
    
    func add(
        _ request: UNNotificationRequest,
        then completionHandler: ((Result<Void, Error>) -> Void)?
    )
}


extension UserNotificationsServiceable {

    func getNotificationSettings() -> Future<UNNotificationSettings, Never> {
        Future { [weak self] resolve in
            self?.notificationCenter.getNotificationSettings { (settings) in
                resolve(.success(settings))
            }
        }
    }
     

    var notificationsSettingsPublisher: Publishers.Share<AnyPublisher<UNNotificationSettings, Never>> {
        getNotificationSettings()
            .eraseToAnyPublisher()
            .share()
    }
    
    
    var authorizationStatusPublisher: Publishers.Share<AnyPublisher<UNAuthorizationStatus, Never>> {
        notificationsSettingsPublisher
            .map(\.authorizationStatus)
            .eraseToAnyPublisher()
            .share()
    }
  
    
    func requestAuthorization(
        withAbilities authorizationOptions: UNAuthorizationOptions = [.alert, .badge, .sound],
        then completionHandler: ((Result<Bool, Error>) -> Void)?
    ) {
        notificationCenter.requestAuthorization(
            options: authorizationOptions
        ) { (wasGranted, error) in
            if let error = error {
                completionHandler?(.failure(error))
            } else {
                completionHandler?(.success(wasGranted))
            }
        }
    }
    
    
    func add(
        _ request: UNNotificationRequest,
        then completionHandler: ((Result<Void, Error>) -> Void)?
    ) {
        notificationCenter.add(request) { (error) in
            if let error = error {
                completionHandler?(.failure(error))
            } else {
                completionHandler?(.success(()))
            }
        }
    }
}


final class UserNotificationsService: UserNotificationsServiceable {
    var notificationCenter: UNUserNotificationCenter
    var authorizationStatus: UNAuthorizationStatus = .notDetermined
    var subscriptions = Set<AnyCancellable>()
    
    
    init(
        notificationCenter: UNUserNotificationCenter = .current()
    ) {
        self.notificationCenter = notificationCenter
    }
}


extension UserNotificationsService {
    static let shared = UserNotificationsService()
}


