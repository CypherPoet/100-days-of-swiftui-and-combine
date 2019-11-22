//
//  GenericFilteredListExample.swift
//  ExploringCoreData
//
//  Created by CypherPoet on 11/21/19.
// ✌️
//

import SwiftUI


struct GenericFilteredListExample: View {
    @Environment(\.managedObjectContext) var moc

    @State private var currentUniverse: Ship.Universe = .starWars
}


// MARK: - Body
extension GenericFilteredListExample {

    var body: some View {
        List {
            Section {
                VStack {
                    Text("Select a Universe")
                        .font(.headline)
                    
                    universePicker
                        .pickerStyle(SegmentedPickerStyle())
                }
                .padding(.vertical)
            }
            
            Section {
                FilteredList(
                    filterKey: "universeValue",
                    filterValue: "\(currentUniverse.rawValue)",
                    buildListItem: { (ship: Ship) in
                        Text(ship.name ?? "")
                    }
                )
            }
        }
        .navigationBarTitle("Generic Filtered Lists")
    }
}


// MARK: - Computeds
extension GenericFilteredListExample {


}


// MARK: - View Variables
extension GenericFilteredListExample {
    
    private var universePicker: some View {
        Picker("Select a Universe", selection: $currentUniverse) {
            ForEach(Ship.Universe.allCases) { universe in
                Text(universe.displayName).tag(universe)
            }
        }
    }
}



// MARK: - Preview
struct GenericFilteredListExampleContainerView_Previews: PreviewProvider {

    static var previews: some View {
        GenericFilteredListExample()
            .environment(\.managedObjectContext, SampleMOC.viewContext)

    }
}
