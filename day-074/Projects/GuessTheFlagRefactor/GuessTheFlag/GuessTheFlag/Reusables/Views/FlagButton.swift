//
//  FlagButton.swift
//  GuessTheFlag
//
//  Created by CypherPoet on 10/16/19.
// ✌️
//

import SwiftUI


struct FlagButton: View {
    let flag: CityFlag
    let onTap: (() -> Void)
    
    var body: some View {
        Button(action: onTap) {
            Image(flag.imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(1.75, contentMode: .fit)
                .clipped()
                .cornerRadius(42)
                .shadow(color: .purple, radius: 9, x: 0, y: -1.3)
        }
    }
}


struct FlagButton_Previews: PreviewProvider {
    
    static var previews: some View {
        FlagButton(
            flag: CityFlag.amsterdam,
            onTap: {}
        )
    }
}
