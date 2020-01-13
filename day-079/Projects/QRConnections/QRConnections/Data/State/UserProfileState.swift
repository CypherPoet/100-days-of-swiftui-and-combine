//
//  UserProfileState.swift
//  QRConnections
//
//  Created by CypherPoet on 1/11/20.
// ✌️
//


import CypherPoetSwiftUIKit_DataFlowUtils
import UserDefault
import Combine
import CoreImage.CIFilterBuiltins
import UIKit


struct UserProfileState: ContactQRCodeRepresentable {
    
    @UserDefault("user-profile-qr-code-data", defaultValue: Data())
    var qrCodeData: Data
    
    @UserDefault("user-profile-uuid-string", defaultValue: UUID().uuidString)
    var uuidString: String
    
    @UserDefault("user-profile-name", defaultValue: "")
    var name: String
    
    
    var uuid: UUID {
        guard let uuid = UUID(uuidString: uuidString) else {
            preconditionFailure("Unable to make UUID from stored `uuidString`")
        }
        
        return uuid
    }
    
    var qrCodeCGImage: CGImage? {
        didSet {
            guard let cgImage = qrCodeCGImage else { return }
            self.qrCodeData = UIImage(cgImage: cgImage).pngData() ?? Data()
        }
    }
}



enum UserProfileSideEffect: SideEffect {
    case generateQRCode(data: Data)
    
    
    func mapToAction() -> AnyPublisher<AppAction, Never> {
        switch self {
        case .generateQRCode(let data):
            return Just(data)
                .flatMap { data in
                    CurrentApp.imageFilteringService.createCGImage(
                        from: CIFilter.qrCodeGenerator(),
                        withAttributes: [
                            "inputMessage": data
                        ]
                    )
                    .map { AppAction.userProfile(.qrCodeImageSet($0)) }
                    .catch { _ in Just(AppAction.userProfile(.qrCodeDataSet(Data()))) }
                }
                .eraseToAnyPublisher()
        }
    }
}


enum UserProfileAction {
    case qrCodeImageSet(CGImage)
    case qrCodeDataSet(Data)
    case userNameSet(String)
}



// MARK: - Reducer
let userProfileReducer: Reducer<UserProfileState, UserProfileAction> = Reducer(
    reduce: { state, action in
        switch action {
        case .qrCodeDataSet(let data):
            state.qrCodeData = data
        case .qrCodeImageSet(let cgImage):
            state.qrCodeCGImage = cgImage
        case .userNameSet(let name):
            state.name = name
        }
    }
)

