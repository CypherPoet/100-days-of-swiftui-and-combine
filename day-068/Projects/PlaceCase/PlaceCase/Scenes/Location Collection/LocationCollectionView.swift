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
            LocationCollectionMapView(
                annotations: collection.locationsArray,
                centerCoordinate: $centerCoordinate
            )
            
            VStack {
                Text("\(collection.locationsArray.count)")
                Text("\(viewModel.locations.count)")
            }
            
            centerIndicator
            
            
            VStack(alignment: .trailing) {
                Spacer()
                
                HStack(alignment: .bottom) {
                    Spacer()
                    addLocationButton
                }
            }
            
        }
        .edgesIgnoringSafeArea(.all)
    }
    
}


// MARK: - Computeds
extension LocationCollectionView {


}

// MARK: - View Variables
extension LocationCollectionView {

    private var centerIndicator: some View {
        Circle()
            .fill(Color.accentColor)
            .frame(width: 100, height: 100)
            .opacity(0.3)
    }
    
    
    private var addLocationButton: some View {
        Button(action: {

        }) {
            Image(systemName: "plus")
        }
    }
}


// MARK: - Preview
struct LocationCollectionView_Previews: PreviewProvider {

    static var previews: some View {
        LocationCollectionView(collection: SampleData.LocationCollections.default)
            .environment(\.managedObjectContext, CoreDataManager.shared.mainContext)
    }
}
