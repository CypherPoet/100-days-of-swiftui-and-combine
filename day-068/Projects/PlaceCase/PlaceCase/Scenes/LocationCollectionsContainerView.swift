//
//  LocationCollectionsContainerView.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/8/19.
// ✌️
//

import SwiftUI


struct LocationCollectionsContainerView: View {
    @ObservedObject private(set) var viewModel: LocationCollectionsContainerViewModel
}


// MARK: - Body
extension LocationCollectionsContainerView {

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isAuthenticated {
                    LocationCollectionsListView(
                        buildDestination: LocationCollectionView.init(collection:)
                    )
                } else {
                    Text("This is app is locked.")
                }
            }
        }
        .navigationBarTitle("PlaceCase")
        .onAppear(perform: viewModel.onAppear)
    }
}




// MARK: - Preview
struct LocationCollectionsContainerView_Previews: PreviewProvider {

    static var previews: some View {
        let viewModel = LocationCollectionsContainerViewModel(authService: SampleData.AuthService())
        
        viewModel.isAuthenticated = true
        
        return LocationCollectionsContainerView(
            viewModel: viewModel
        )
        .environment(\.managedObjectContext, CurrentApp.coreDataManager.mainContext)
    }
}
