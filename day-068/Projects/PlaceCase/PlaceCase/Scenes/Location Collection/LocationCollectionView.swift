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
    @Environment(\.managedObjectContext) private var managedObjectContext
    @ObservedObject private(set) var viewModel: LocationCollectionViewModel
    
    let collection: LocationCollection
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    
    
    init(collection: LocationCollection) {
        self.collection = collection
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
        .alert(item: $viewModel.selectedLocation) { _ in
            Alert(
                title: Text(viewModel.selectedLocationAlertTitle),
                message: Text(viewModel.selectedLocationAlertMessage),
                dismissButton: .default(Text("OK"))
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
            annotations: collection.locationsArray,
            centerCoordinate: $centerCoordinate,
            selectedLocation: $viewModel.selectedLocation
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
        guard let context = collection.managedObjectContext else { fatalError() }

        let location = Location(context: context)
        
        location.title = "Untitled Location"
        location.latitude = centerCoordinate.latitude
        location.longitude = centerCoordinate.longitude

        collection.addToLocations(location)
        
        CoreDataManager.shared.save(context)
    }
}



// MARK: - Preview
struct LocationCollectionView_Previews: PreviewProvider {

    static var previews: some View {
        LocationCollectionView(collection: SampleData.LocationCollections.default)
            .environment(\.managedObjectContext, CoreDataManager.shared.mainContext)
    }
}
