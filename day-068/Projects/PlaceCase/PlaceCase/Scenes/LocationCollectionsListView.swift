//
//  LocationCollectionsListView.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/10/19.
// ✌️
//

import SwiftUI


struct LocationCollectionsListView<Destination: View>: View {
    @FetchRequest(
        fetchRequest: LocationCollection.FetchRequest.all,
        animation: nil
    ) var collections: FetchedResults<LocationCollection>
    
    
    let buildDestination: ((LocationCollection) -> Destination)
}



// MARK: - Body
extension LocationCollectionsListView {

    var body: some View {
        List(collections, id: \.self) { collection in
            NavigationLink(
                collection.title ?? "Untitled Collection",
                destination: self.buildDestination(collection)
                // ⚠️ This currently breaks when we navigate back to the list view from the destination.
                // It appears to be a SwiftUI bug consonant to iOS 13.3: https://stackoverflow.com/a/59291574/8859365
            )
        }
        .navigationBarTitle(Text("Location Collections"))
        
        // 📝 NOTE: Trying to reference the `collections` results as a standalone variable here
        // appears to prevent the view from reloading when data is saved in the background. (Xcode 11.2.1 (11B500))
        //
        // I'm not sure if this is a bug, but if we wanted the kind of behavior below, it might be better to use
        // a view model that wraps a `FetchedResultsController` and has a bit more control over executing fetchRequests.
        // and setting the fetched results.
        
//        if !collections.isEmpty {
//            List(collections, id: \.self) { collection in
//                Text(collection.title ?? "Collection")
//            }
//        } else {
//            Text("No collections found.")
//        }
    }
}


// MARK: - Computeds
extension LocationCollectionsListView {
}


// MARK: - View Variables
extension LocationCollectionsListView {
}



// MARK: - Preview
struct LocationCollectionsListView_Previews: PreviewProvider {

    static var previews: some View {
        
        NavigationView {
            LocationCollectionsListView(
                buildDestination: { _ in EmptyView() }
            )
            .environment(\.managedObjectContext, CurrentApp.coreDataManager.mainContext)
        }
    }
}
