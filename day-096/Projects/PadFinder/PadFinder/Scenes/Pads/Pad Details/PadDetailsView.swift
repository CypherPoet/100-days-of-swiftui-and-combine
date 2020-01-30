//
//  PadDetailsView.swift
//  PadFinder
//
//  Created by CypherPoet on 1/27/20.
// ✌️
//

import SwiftUI
import MapKit
import CypherPoetSwiftUIKit


struct PadDetailsView {
    @ObservedObject var viewModel: ViewModel
    
    var onFavoriteToggled: ((Pad) -> Void)?
}


// MARK: - View
extension PadDetailsView: View {

    var body: some View {
        GeometryReader { geometry in
            List {
                if self.viewModel.mapSnapshotImage != nil {
                    Image(uiImage: self.viewModel.mapSnapshotImage!)
                        .resizable()
                        .scaledToFit()
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                }

                self.coordinateHeader
                    .padding(.vertical)
                    
                if self.viewModel.webLinkData.isEmpty == false {
                    self.linksSection
                }

                self.optionsSection
            }
            .embedInScrollView(axes: .vertical)
        }
        .navigationBarTitle(Text(viewModel.padNameText), displayMode: .inline)
        .onAppear {
            self.viewModel.takeMapSnapshot(
                size: CGSize(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.width * 0.75
                )
            )
        }
    }
}


// MARK: - Computeds
extension PadDetailsView {
}


// MARK: - View Variables
extension PadDetailsView {
    
    private var coordinateHeader: some View {
        HStack(spacing: 12) {
            Spacer()
            
            Image(systemName: "mappin")
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .clipShape(Circle())
            
            Group {
                Text("Lat: ").fontWeight(.bold)
                    + Text(self.viewModel.latitudeText)

                Text("Lon: ").fontWeight(.bold)
                    + Text(self.viewModel.longitudeText)
            }
            .embedInCompactableStack()
            
            Spacer()
        }
    }
    
    
    private var linksSection: some View {
        Section(
            header: Text("Links").font(.headline)
        ) {
            ForEach(viewModel.webLinkData, id: \.0) { linkItem in
                Button(action: {
                    UIApplication.shared.open(linkItem.url)
                }) {
                    Text(linkItem.hostName)
                        .foregroundColor(.accentColor)
                }
            }
        }
    }
    
    
    private var optionsSection: some View {
        Section(
            header: Text("Options").font(.headline)
        ) {
            favoritesButton
        }
    }
    
    
    private var favoritesButton: some View {
        Button(action: {
            self.onFavoriteToggled?(self.viewModel.pad)
        }) {
            Text(viewModel.favoritesButtonText)
                .foregroundColor(.accentColor)
        }
    }
}


// MARK: - Private Helpers
private extension PadDetailsView {
}



// MARK: - Preview


struct PadDetailsView_Previews: PreviewProvider {

    static var previews: some View {
        let snapshotOptions = PreviewData.Pads.pad1.baseSnapshotOptions
        
        return NavigationView {
            PadDetailsView(
                viewModel: .init(
                    pad: PreviewData.Pads.pad1,
                    isPadFavorited: false,
                    snapshotService: MapSnapshottingService(
                        snapshotOptions: snapshotOptions
                    )
                )
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(PreviewData.AppStores.withPads)
    }
}
