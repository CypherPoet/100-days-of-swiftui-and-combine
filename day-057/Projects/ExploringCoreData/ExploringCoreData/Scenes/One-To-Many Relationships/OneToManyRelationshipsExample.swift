//
//  OneToManyRelationshipsExample.swift
//  ExploringCoreData
//
//  Created by CypherPoet on 11/22/19.
// ✌️
//

import SwiftUI


struct OneToManyRelationshipsExample: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Country.entity(), sortDescriptors: []) var countries: FetchedResults<Country>
}



// MARK: - Body
extension OneToManyRelationshipsExample {

    var body: some View {
        VStack {
            candyList
            addDataButton
        }
        .navigationBarTitle("One-to-many Relationships")
    }
}


// MARK: - Computeds
extension OneToManyRelationshipsExample {
}


// MARK: - View Variables
extension OneToManyRelationshipsExample {
    
    private var candyList: some View {
        FilteredList(
            filterKey: "name",
            filterValue: "U",
            sortDescriptors: [
                Country.SortDescriptor.byAbbreviation,
            ],
            buildListItem: { (country: Country) in
                CandyListSection(country: country)
            }
        )
    }
    
    
    private var addDataButton: some View {
        Button(action: {
            let uk = Country(context: self.moc)
            uk.name = "United Kingdom"
            uk.abbreviation = "UK"
            uk.flag = "🇬🇧"
            
            let switzerland = Country(context: self.moc)
            switzerland.name = "Switzerland"
            switzerland.abbreviation = "CH"
            switzerland.flag = "🇨🇭"
            
            let usa = Country(context: self.moc)
            usa.name = "United States of America"
            usa.abbreviation = "USA"
            usa.flag = "🇺🇸"
            

            let candy1 = Candy(context: self.moc)
            candy1.name = "Mars"
            candy1.country = uk

            let candy2 = Candy(context: self.moc)
            candy2.name = "KitKat"
            candy2.country = uk

            let candy3 = Candy(context: self.moc)
            candy3.name = "Twix"
            candy3.country = uk

            let candy4 = Candy(context: self.moc)
            candy4.name = "Toblerone"
            candy4.country = switzerland

            let candy5 = Candy(context: self.moc)
            candy5.name = "Reese's Cups"
            candy5.country = usa
            
            let candy6 = Candy(context: self.moc)
            candy6.name = "Hershey's Gold"
            candy6.country = usa
            
            
            do {
                try self.moc.save()
            } catch {
                print("Error while saving candies.")
            }
        }) {
            Text("Add Candy Data 🍫")
        }
    }
}



// MARK: - Preview
struct OneToManyRelationshipsExample_Previews: PreviewProvider {

    static var previews: some View {
        OneToManyRelationshipsExample()
            .environment(\.managedObjectContext, SampleMOC.viewContext)
    }
}
