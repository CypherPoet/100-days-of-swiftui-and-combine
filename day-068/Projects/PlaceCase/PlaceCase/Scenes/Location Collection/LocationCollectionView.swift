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
    @ObservedObject var viewModel: ViewModel
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
}


// MARK: - Body
extension LocationCollectionView {

    var body: some View {
        ZStack {
            mapUnderlay
            centerIndicator
            mapControls
        }
        // 🤔 FIXME (Xcode 11.3): In some cases, even when `$viewModel.isShowingAlert` is true,
        // the alert for showing location details never surfaces on the UI.
        //
        // I'm not sure if this is a bug, or a limitation of the
        // the way alerts currently attach themselves via modifiers, but in any case, it's all the more
        // reason to be conservative with alerts and design more thoughtful, richer, "real" views for
        // presenting data such as location details.
        .alert(isPresented: $viewModel.isShowingAlert, content: { self.currentAlert })
        .sheet(
            isPresented: $viewModel.isShowingEditView,
            onDismiss: {
                guard let context = self.viewModel.selectedLocation?.managedObjectContext else {
                    fatalError()
                }
                
                CurrentApp.coreDataManager.save(context)
            }
        ) {
            if self.viewModel.selectedLocation != nil {
                EditLocationView(
                    viewModel: EditLocationViewModel(
                        location: self.viewModel.selectedLocation!,
                        wikiPagesState: self.store.state.wikiPagesState
                    )
                )
                .environmentObject(self.store)
            } else {
                Text("No Location found for editing")
            }
        }
    }
}


// MARK: - Computeds
extension LocationCollectionView {
    
    var currentAlert: Alert {
        switch viewModel.currentAlertState {
        case .currentLocationDisabled:
            return Alert(
                title: Text("Location Services are Disabled"),
                message: Text("Location authorization settings can be changed from within the Settings app."),
                dismissButton: .default(Text("👌 Got It"))
            )
        case .currentLocationReadingFailed:
            return Alert(
                title: Text("Error while attempting to read location."),
                message: Text("Your current location could not be determined."),
                dismissButton: .default(Text("OK"))
            )
        case .locationSelected:
            return Alert(
                title: Text(viewModel.selectedLocationAlertTitle),
                message: Text(viewModel.selectedLocationAlertMessage),
                primaryButton: .default(
                    Text("Edit"),
                    action: { self.viewModel.isShowingEditView = true }
                ),
                secondaryButton: .cancel(Text("OK"))
            )
        default:
            preconditionFailure("No alert should be set")
        }
    }
}


// MARK: - View Variables
extension LocationCollectionView {
    
    private var mapUnderlay: some View {
        LocationCollectionMapView(
            annotations: viewModel.locations,
            startingCenterCoordinate: viewModel.userLocationCoordinate,
            onSelectLocation: locationSelected(_:),
            onCenterChanged: centerCoordinateChanged(_:)
        )
        .edgesIgnoringSafeArea(.all)
    }
    

    private var centerIndicator: some View {
        Circle()
            .fill(Color.accentColor)
            .frame(width: 32, height: 32)
            .opacity(0.3)
    }
    

    private var mapControls: some View {
        VStack(alignment: .trailing) {
            Spacer()
            
            HStack(alignment: .bottom) {
                Spacer()
                
                VStack {
                    snapToCurrentLocationButton
                    addLocationButton
                }
                .padding(.trailing)
            }
        }
    }
    
    
    private var addLocationButton: some View {
        Button(action: {
            self.createNewLocation()
        }) {
            Image(systemName: "plus.rectangle.fill")
                .font(.title)
                .padding(24)
                .background(Color.accentColor.opacity(0.8))
                .foregroundColor(.white)
        }
        .clipShape(Circle())
    }
    
    
    private var snapToCurrentLocationButton: some View {
        Button(action: {
            self.viewModel.activateLocationManager()
        }) {
            Image(systemName: "location.fill")
                .font(.headline)
                .padding(18)
                .background(Color.accentColor.opacity(0.8))
                .foregroundColor(.white)
        }
        .clipShape(Circle())
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
        viewModel.selectedLocation = location
        viewModel.currentAlertState = .locationSelected
    }
    
    
    func centerCoordinateChanged(_ newCoordinate: CLLocationCoordinate2D) {
        centerCoordinate = newCoordinate
    }
}



// MARK: - Preview
struct LocationCollectionView_Previews: PreviewProvider {

    static var previews: some View {
        LocationCollectionView(
            viewModel: .init(collection: SampleData.LocationCollections.default)
        )
        .environment(\.managedObjectContext, CurrentApp.coreDataManager.mainContext)
        .environmentObject(SampleData.SampleAppStore.default)
    }
}
