//
//  PreviewData+AppStore.swift
//  PadFinder
//
//  Created by CypherPoet on 1/26/20.
// ✌️
//

import Foundation


extension PreviewData {
    
    enum Pads {
        static let pad1 = Pad(
            id: 166,
            name: "Rocket Lab Launch Complex 1",
            padType: .landing,
//            mapURL: URL(string: #"https:\/\/twitter.com\/rocketlab"#.replacingOccurrences(of: #"\"#, with: ""))!,
            mapURL: URL(
                string: #"https:\/\/www.google.ee\/maps\/place\/39°15'46.2\"S+177°51'52.1\"E\/"#
                    .replacingOccurrences(of: #"\"#, with: "")
                    .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            )!,
            latitude: -39.262833000000000,
            longitude: 177.864469000000000,
            isRetired: false,
            infoURLs: [
                URL(string: #"http:\/\/www.rocketlabusa.com\/"#.replacingOccurrences(of: #"\"#, with: ""))!,
                URL(string: #"https:\/\/twitter.com\/rocketlab"#.replacingOccurrences(of: #"\"#, with: ""))!,
                URL(string: #"https:\/\/www.youtube.com\/user\/RocketLabNZ"#.replacingOccurrences(of: #"\"#, with: ""))!,
                URL(string: #"https:\/\/www.facebook.com\/RocketLabUSA"#.replacingOccurrences(of: #"\"#, with: ""))!,
                URL(string: #"https:\/\/www.linkedin.com\/company\/rocket-lab-limited"#.replacingOccurrences(of: #"\"#, with: ""))!,
            ]
        )
    }
    
    enum PadsStates {
        static let `default`: PadsState = {
            .init(
                dataFetchingState: .fetched([
                    PreviewData.Pads.pad1,
                ])
            )
        }()
    }
    
    
    enum AppStores {
        static let empty: AppStore = {
            AppStore(initialState: .init(), appReducer: appReducer)
        }()
        
        
        static let withPads: AppStore = {
            AppStore(
                initialState: .init(
                    padsState: PreviewData.PadsStates.default
                ),
                 appReducer: appReducer
            )
        }()
    }
}
