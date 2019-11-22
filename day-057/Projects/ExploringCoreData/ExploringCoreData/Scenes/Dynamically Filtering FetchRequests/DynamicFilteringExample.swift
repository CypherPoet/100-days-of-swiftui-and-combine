//
//  DynamicFilteringExample.swift
//  ExploringCoreData
//
//  Created by CypherPoet on 11/21/19.
// ✌️
//

import SwiftUI


struct DynamicFilteringExample: View {
    @Environment(\.managedObjectContext) var moc

    @State private var currentUniverse: Ship.Universe = .starWars
}


// MARK: - Body
extension DynamicFilteringExample {

    var body: some View {
        List {
            Section(
                header: Text("Select a Universe")
                    .font(.headline)
            ) {
                universePicker
                    .pickerStyle(SegmentedPickerStyle())
            }
            
            Section {
//                DynamicFilteringExampleListView(ships: self.currentFetchRequest.wrappedValue) // 🤔 This straight-up crashses. Perhaps, it has something to do with passing `FetchedResults` to structs?... not quite sure, though.
                DynamicFilteringExampleListView(universe: currentUniverse)
            }
        }
        .navigationBarTitle("Dynamic Filtering")
    }
}


// MARK: - Computeds
extension DynamicFilteringExample {
}


// MARK: - View Variables
extension DynamicFilteringExample {
    
    private var universePicker: some View {
        Picker("Select a Universe", selection: $currentUniverse) {
            ForEach(Ship.Universe.allCases) { universe in
                Text(universe.displayName).tag(universe)
            }
        }
    }
}



// MARK: - Preview
struct DynamicFilteringExampleContainerView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            DynamicFilteringExample()
                .environment(\.managedObjectContext, SampleMOC.viewContext)
        }
    }
}
