//
//  MainView.swift
//  ExploringCoreData
//
//  Created by CypherPoet on 11/20/19.
// ✌️
//

import SwiftUI


struct MainView: View {
    @Environment(\.managedObjectContext) var moc
}


// MARK: - Body
extension MainView {

    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink(destination: FilteringExample()) {
                        Text("Filtering with NSPredicate")
                    }
                    NavigationLink(destination: DynamicFilteringExample()) {
                        Text("Dynamically Filtering FetchRequests")
                    }
                    NavigationLink(destination: GenericFilteredListExample()) {
                        Text("Generic").italic() + Text(" Dynamic Filtered Lists")
                    }
                    NavigationLink(destination: OneToManyRelationshipsExample()) {
                        Text("One-to-many Relationships")
                    }
                }
            }
            .navigationBarTitle("Exploring Core Data")
        }
    }
}


// MARK: - Computeds
extension MainView {

}


// MARK: - View Variables
extension MainView {


}



// MARK: - Preview
struct MainView_Previews: PreviewProvider {

    static var previews: some View {
        MainView()
    }
}
