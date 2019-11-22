//
//  FilteringExample.swift
//  ExploringCoreData
//
//  Created by CypherPoet on 11/21/19.
// ✌️
//

import SwiftUI


struct FilteringExample: View {
    enum Predicate {
        static let starWars = NSPredicate(format: "universe == %@", "Star Wars")
        static let nameLessThanF = NSPredicate(format: "name < %@", "F")
        static let universeInGroup = NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])
        static let beginsWithE = NSPredicate(format: "name BEGINSWITH[c] %@", "e")
        static let universeContainsStar = NSPredicate(format: "universe CONTAINS[c] %@", "star")
        static let nameHasNoA = NSPredicate(format: "NOT name CONTAINS[c] %@", "a")
    }
    
    @Environment(\.managedObjectContext) var moc

    
//    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: Predicate.starWars) var ships: FetchedResults<Ship>
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: Predicate.nameHasNoA) var ships: FetchedResults<Ship>
}


// MARK: - Body
extension FilteringExample {

    var body: some View {
        
        VStack {
            List {
                ForEach(ships, id: \.self) { ship in
                    Text(ship.name ?? "Unknown Name")
                }
            }

            addShipsButton
        }
    }
}


// MARK: - Computeds
extension FilteringExample {
}


// MARK: - View Variables
extension FilteringExample {

    private var addShipsButton: some View {
        
        Button(action: {
            let ship1 = Ship(context: self.moc)
            ship1.name = "Enterprise"
            ship1.universe = .starTrek

            let ship2 = Ship(context: self.moc)
            ship2.name = "Defiant"
            ship2.universe = .starTrek

            let ship3 = Ship(context: self.moc)
            ship3.name = "Millennium Falcon"
            ship3.universe = .starWars

            let ship4 = Ship(context: self.moc)
            ship4.name = "Executor"
            ship4.universe = .starWars
            
            try? self.moc.save()
        }) {
            Text("Add Ships 🚀")
        }
    }
}



// MARK: - Preview
struct FilteringExampleListView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            FilteringExample()
                .environment(\.managedObjectContext, SampleMOC.viewContext)
        }
    }
}
