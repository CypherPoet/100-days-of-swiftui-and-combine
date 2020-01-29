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
}


// MARK: - View
extension PadDetailsView: View {

    var body: some View {
        GeometryReader { geometry in
            VStack {
                if self.viewModel.mapSnapshotImage != nil {
                    Image(uiImage: self.viewModel.mapSnapshotImage!)
                        .resizable()
                        .scaledToFit()
                }
                
                Group {
                    self.coordinateHeader
                    
                    VStack(alignment: .leading) {
                        if self.viewModel.webLinkData.isEmpty == false {
                            self.linksSection
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .onAppear {
                self.viewModel.takeMapSnapshot(
                    with: CGSize(
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.width * 0.75
                    )
                )
            }
            .embedInScrollView(axes: .vertical)
        }
        .navigationBarTitle(Text(viewModel.padNameText), displayMode: .inline)
    }
}


// MARK: - Computeds
extension PadDetailsView {
}


// MARK: - View Variables
extension PadDetailsView {
    
    private var coordinateHeader: some View {
        HStack(spacing: 12) {
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
        }
        .padding(.top)
    }
    
    
    private var linksSection: some View {
        Section(
            header: Text("Links").font(.headline)
        ) {
            List(viewModel.webLinkData, id: \.0) { linkItem in
                Button(action: {
                    UIApplication.shared.open(linkItem.url)
                }) {
                    Text(linkItem.hostName)
                        .foregroundColor(.accentColor)
                }
            }
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
                    snapshotService: MapSnapshottingService(
                        snapshotOptions: snapshotOptions
                    )
                )
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
