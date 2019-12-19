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
                    authenticationNotice
                }
            }
        }
        .navigationBarTitle("PlaceCase")
        .alert(item: $viewModel.authenticationError) { _ in self.authenticationErrorAlert }
    }
}


// MARK: - View Variables
extension LocationCollectionsContainerView {
    
    private var authenticateButton: some View {
        Button(action: {
            self.viewModel.authenticate()
        }) {
            Text("Authenticate")
                .font(.headline)
                .foregroundColor(.white)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.accentColor)
                .shadow(color: .gray, radius: 3, x: 0, y: 0)
        )
    }
    
    
    private var authenticationNotice: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 10.0) {
                Text("🛡 This is app is locked.")
                Text("Please try authenticating to access location lists.")
            }
            
            Spacer()
            authenticateButton
            Spacer()
            Spacer()
        }
        .padding()
    }
    
    
    private var authenticationErrorAlert: Alert {
        .init(
            title: Text(viewModel.authenticationErrorAlertTitle),
            message: Text(viewModel.authenticationErrorAlertBody),
            dismissButton: .default(Text("OK"))
        )
    }
}



// MARK: - Preview
struct LocationCollectionsContainerView_Previews: PreviewProvider {

    static var previews: some View {
        let viewModel = LocationCollectionsContainerViewModel(authService: SampleData.AuthService())
        
        viewModel.isAuthenticated = false
        
        return LocationCollectionsContainerView(
            viewModel: viewModel
        )
        .environment(\.managedObjectContext, CurrentApp.coreDataManager.mainContext)
    }
}
