//
//  DynamicFilteringExampleListView.swift
//  ExploringCoreData
//
//  Created by CypherPoet on 11/21/19.
// ✌️
//

import SwiftUI


struct DynamicFilteringExampleListView: View {
    private(set) var fetchRequest: FetchRequest<Ship>
    

    init(universe: Ship.Universe) {
        self.fetchRequest = FetchRequest<Ship>(
            entity: Ship.entity(),
            sortDescriptors: [],
//            predicate: NSPredicate(format: "name == %@", universe == .starWars ? "Millenium Falcon" : "Enterprise"),
//            predicate: NSPredicate(format: "universeValue == %@", "\(universe.rawValue)"),
            predicate: NSPredicate(format: "universeValue == %d", universe.rawValue),
            animation: nil
        )
    }
}


// MARK: - Body
extension DynamicFilteringExampleListView {

    var body: some View {
        List(ships, id: \.self) { ship in
            Text(ship.name ?? "")
        }
    }
}


// MARK: - Computeds
extension DynamicFilteringExampleListView {
    
    var ships: FetchedResults<Ship> { fetchRequest.wrappedValue }

}


// MARK: - View Variables
extension DynamicFilteringExampleListView {


}



// MARK: - Preview
struct DynamicFilteringExampleListView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            DynamicFilteringExampleListView(universe: .starTrek)
                .environment(\.managedObjectContext, SampleMOC.viewContext)
            
            DynamicFilteringExampleListView(universe: .starWars)
                .environment(\.managedObjectContext, SampleMOC.viewContext)
        }
    }
}
