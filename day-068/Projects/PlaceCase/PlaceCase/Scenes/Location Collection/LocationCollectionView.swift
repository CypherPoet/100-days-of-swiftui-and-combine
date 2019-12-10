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
        mapViewSection
            .edgesIgnoringSafeArea(.all)
    }
    
}


// MARK: - Computeds
extension LocationCollectionView {


}


// MARK: - View Variables
extension LocationCollectionView {

    private var mapViewSection: some View {
        ZStack {
//            LocationCollectionMapView(
//                annotations: [SampleData.Annotations.santorini],
//                centerCoordinate: $centerCoordinate
//            )
            
            Circle()
                .fill(Color.accentColor)
                .frame(width: 100, height: 100)
                .opacity(0.3)
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
