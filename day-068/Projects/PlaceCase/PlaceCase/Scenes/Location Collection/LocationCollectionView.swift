//
//  LocationCollectionView.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/6/19.
// ✌️
//

import SwiftUI




struct LocationCollectionView: View {
    @ObservedObject private(set) var viewModel: LocationCollectionViewModel
}


// MARK: - Body
extension LocationCollectionView {

    var body: some View {
        Group {
            if viewModel.isAuthenticated {
                MapView(annotations: [SampleData.Annotations.santorini])
            } else {
                Text("This is app is locked.")
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: viewModel.onAppear)
    }
    
}


// MARK: - Computeds
extension LocationCollectionView {


}


// MARK: - View Variables
extension LocationCollectionView {


}



// MARK: - Preview
struct LocationCollectionView_Previews: PreviewProvider {

    static var previews: some View {
        LocationCollectionView(
            viewModel: LocationCollectionViewModel(
                authService: SampleData.AuthService()
            )
        )
    }
}
