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
//    var entity: NSEntityDescription
//    var predicate: NSPredicate
    private var filterKey: String
    private var filterValue: String
    
    var fetchRequest: FetchRequest<ManagedObject>
    var buildListItem: (ManagedObject) -> Content
    
    
    init(
        filterKey: String,
        filterValue: String,
        @ViewBuilder buildListItem: @escaping (ManagedObject) -> Content
    ) {
        self.filterKey = filterKey
        self.filterValue = filterValue
        self.buildListItem = buildListItem
        
        // 🤔 Lots of potential to make this even moar configurable, IMO
        self.fetchRequest = .init(
            entity: ManagedObject.entity(),
            sortDescriptors: [],
            predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue),
            animation: nil
        )
    }
}


// MARK: - Body
extension FilteredList {

    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { object in
            self.buildListItem(object)
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
