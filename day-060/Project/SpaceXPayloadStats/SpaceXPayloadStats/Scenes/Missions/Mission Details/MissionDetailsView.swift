//
//  MissionDetailsView.swift
//  SpaceXPayloadStats
//
//  Created by CypherPoet on 11/23/19.
// ✌️
//

import SwiftUI


struct MissionDetailsView<Destination: View>: View {
    let buildDestination: ((Payload.ID) -> Destination)
    private let viewModel: MissionDetailsViewModel
    

    init(
        mission: Mission,
        buildDestination: @escaping ((Payload.ID) -> Destination)
    ) {
        self.buildDestination = buildDestination
        self.viewModel = MissionDetailsViewModel(mission: mission)
    }
}


// MARK: - Body
extension MissionDetailsView {
    
    var body: some View {
        List {
            Section {
                Text(viewModel.missionDescription)
                    .padding()
                    .layoutPriority(1)
            }
            
            if viewModel.hasWebLinks {
                webLinksSection
            }
            
            
            if viewModel.hasPayloads {
                payloadsSection
            }
        }
        .navigationBarTitle(Text(viewModel.missionName), displayMode: .automatic)
    }
}


// MARK: - View Variables
extension MissionDetailsView {
    
    private var webLinksSection: some View {
        Section(header: SectionHeader(title: "🌐  Web Links")) {
            ForEach(viewModel.webLinks, id: \.0) { webLinkItem in
                Button(action: {
                    self.open(externalURL: webLinkItem.url)
                }) {
                    Text(webLinkItem.linkName)
                }
            }
        }
    }
    
    
    private var payloadsSection: some View {
        Section(header: SectionHeader(title: "🛰  Payload History")) {
            ForEach(viewModel.payloadIDs, id: \.self) { payloadID in
                NavigationLink(destination: self.buildDestination(payloadID)) {
                    Text(payloadID)
                }
            }
        }
    }
}



// MARK: - Private Helpers
private extension MissionDetailsView {
    
    func open(externalURL url: URL) {
        UIApplication.shared.open(url)
    }
}


// MARK: - Preview
struct MissionDetailsView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            NavigationView {
                MissionDetailsView(
                    mission: SampleMissions.telstar,
                    buildDestination: { _ in EmptyView() }
                )
            }
            
            NavigationView {
                MissionDetailsView(
                    mission: SampleMissions.idridiumNext,
                    buildDestination: { _ in EmptyView() }
                )
            }
        }
    }
}


private struct SectionHeader: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .scaledSystemFont(size: 20, weight: .semibold)
                .foregroundColor(.accentColor)
            Spacer()
        }
        .padding(.vertical, 14)
        .padding(.horizontal)
        .background(Color.accentColor.opacity(0.2).brightness(0.2))
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}
