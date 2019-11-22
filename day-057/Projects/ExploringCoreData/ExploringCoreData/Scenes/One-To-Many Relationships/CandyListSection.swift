//
//  CandyListSection.swift
//  ExploringCoreData
//
//  Created by CypherPoet on 11/22/19.
// ✌️
//

import SwiftUI


struct CandyListSection: View {
    var country: Country
}


// MARK: - Body
extension CandyListSection {

    var body: some View {
        Section(
            header:
                Text(country.wrappedAbbreviation) +
                Text(" ") +
                Text(country.wrappedFlag)
        ) {
            ForEach(country.candiesArray, id: \.self) { candy in
                Text(candy.wrappedName)
            }
        }
    }
}



// MARK: - View Variables
extension CandyListSection {


}



// MARK: - Preview
struct CandyListSection_Previews: PreviewProvider {

    static var previews: some View {
        List {
            CandyListSection(country: SampleCountry.usa)
        }
    }
}
