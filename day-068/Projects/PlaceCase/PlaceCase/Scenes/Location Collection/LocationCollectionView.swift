//
//  LocationCollectionView.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/6/19.
// ✌️
//

import SwiftUI
import MapKit


struct LocationCollectionView: View {
    @EnvironmentObject var store: AppStore
    
    @ObservedObject private(set) var viewModel: LocationCollectionViewModel
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State var selectedLocation: Location? = nil
    @State private var isShowingEditView = false
    @State private var isShowingSelectedLocationAlert = false
    
    
    init(collection: LocationCollection) {
        self.viewModel = LocationCollectionViewModel(collection: collection)
    }
}


// MARK: - Body
extension LocationCollectionView {

    var body: some View {
        ZStack {
            mapUnderlay
            
            centerIndicator
            
            addLocationButton
        }
        .sheet(
            isPresented: $isShowingEditView,
            onDismiss: {
                guard let context = self.selectedLocation?.managedObjectContext else {
                    fatalError()
                }
                
                CurrentApp.coreDataManager.save(context)
            }
        ) {
            if self.selectedLocation != nil {
                EditLocationView(location: self.selectedLocation!)
                    .environmentObject(self.store)
            } else {
                Text("No Location found for editing")
            }
        }
        .alert(isPresented: $isShowingSelectedLocationAlert) {
            Alert(
                title: Text(selectedLocation?.title ?? "Undisclosed Location"),
                message: Text(selectedLocation?.longDescription ?? "No description has been provided yet."),
                primaryButton: .default(Text("Edit"), action: {
                    self.isShowingEditView = true
                }),
                secondaryButton: .cancel(Text("OK"))
            )
        }
    }
    
}


// MARK: - Computeds
extension LocationCollectionView {
}


// MARK: - View Variables
extension LocationCollectionView {
    
    private var mapUnderlay: some View {
        LocationCollectionMapView(
//            annotations: collection.locationsArray,
//            annotations: viewModel.locations,
            annotations: viewModel.collection.locationsArray,
            centerCoordinate: $centerCoordinate,
            onSelectLocation: locationSelected(_:)
        )
        .edgesIgnoringSafeArea(.all)
    }
    

    private var centerIndicator: some View {
        Circle()
            .fill(Color.accentColor)
            .frame(width: 32, height: 32)
            .opacity(0.3)
    }
    

    private var addLocationButton: some View {
        VStack(alignment: .trailing) {
            Spacer()
            
            HStack(alignment: .bottom) {
                Spacer()
                
                Button(action: {
                    self.createNewLocation()
                }) {
                    Image(systemName: "plus.rectangle.fill")
                        .padding(24)
                }
                .background(Color.accentColor.opacity(0.8))
                .foregroundColor(.white)
                .font(.title)
                .clipShape(Circle())
                .padding(.trailing)
            }
        }
    }
}


// MARK: - Private Helpers
private extension LocationCollectionView {
    
    func createNewLocation() {
        guard let context = viewModel.collection.managedObjectContext else { fatalError() }

        let location = Location(context: context)
        
        location.title = "Untitled Location"
        location.latitude = centerCoordinate.latitude
        location.longitude = centerCoordinate.longitude

        viewModel.collection.addToLocations(location)
        
        CurrentApp.coreDataManager.save(context)
    }
    
    
    func locationSelected(_ location: Location) {
//        viewModel.selectedLocation = location
//        viewModel.isShowingSelectedLocationAlert = true
        self.selectedLocation = location
        self.isShowingSelectedLocationAlert = true
    }
}



// MARK: - Preview
struct LocationCollectionView_Previews: PreviewProvider {

    static var previews: some View {
        LocationCollectionView(collection: SampleData.LocationCollections.default)
            .environmentObject(SampleData.SampleAppStore.default)
    }
}
