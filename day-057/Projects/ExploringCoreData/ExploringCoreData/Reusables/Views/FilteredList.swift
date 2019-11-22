//
//  FilteredList.swift
//  ExploringCoreData
//
//  Created by CypherPoet on 11/21/19.
// ✌️
//

import SwiftUI
import CoreData


struct FilteredList<ManagedObject: NSManagedObject, Content: View>: View {
    private var filterKey: String
    private var filterValue: String
    
    /// The name of the [string comparison](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Predicates/Articles/pSyntax.html)
    /// to be used between the `filterKey` and `filterValue`
    private var filterComparison: String
    
    private var sortDescriptors: [NSSortDescriptor]
    
    var fetchRequest: FetchRequest<ManagedObject>
    var buildListItem: (ManagedObject) -> Content
    
    
    init(
        filterKey: String,
        filterValue: String,
        filterComparison: String = "BEGINSWITH",
        sortDescriptors: [NSSortDescriptor] = [],
        @ViewBuilder buildListItem: @escaping (ManagedObject) -> Content
    ) {
        self.filterKey = filterKey
        self.filterValue = filterValue
        self.filterComparison = filterComparison
        self.sortDescriptors = sortDescriptors
        self.buildListItem = buildListItem
        
        // 🤔 Lots of potential to make this even moar configurable, IMO
        self.fetchRequest = .init(
            entity: ManagedObject.entity(),
            sortDescriptors: sortDescriptors,
            predicate: NSPredicate(format: "%K \(filterComparison) %@", filterKey, filterValue),
            animation: nil
        )
    }
}


// MARK: - Body
extension FilteredList {

    var body: some View {
        List {
            ForEach(fetchRequest.wrappedValue, id: \.self) { object in
                self.buildListItem(object)
            }
        }
    }
}


// MARK: - Computeds
extension FilteredList {


}


// MARK: - View Variables
extension FilteredList {


}



//// MARK: - Preview
//struct FilteredList_Previews: PreviewProvider {
//
//    static var previews: some View {
//        FilteredList()
//    }
//}
