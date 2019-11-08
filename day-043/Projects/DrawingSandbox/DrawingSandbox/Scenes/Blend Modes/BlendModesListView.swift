//
//  BlendModesListView.swift
//  DrawingSandbox
//
//  Created by CypherPoet on 11/6/19.
// ✌️
//

import SwiftUI


struct BlendModesListView: View {
    let blendModes: [(name: String, blendMode: BlendMode)] = [
        (name: "Color", blendMode: .color),
        (name: "Color Burn", blendMode: .colorBurn),
        (name: "Color Dodge", blendMode: .colorDodge),
        (name: "Darken", blendMode: .darken),
        (name: "Destination Out", blendMode: .destinationOut),
        (name: "Destination Over", blendMode: .destinationOver),
        (name: "Difference", blendMode: .difference),
        (name: "Exclusion", blendMode: .exclusion),
        (name: "Hard Light", blendMode: .hardLight),
        (name: "Hue", blendMode: .hue),
        (name: "Lighten", blendMode: .lighten),
        (name: "Luminosity", blendMode: .luminosity),
        (name: "Multiply", blendMode: .multiply),
        (name: "Normal", blendMode: .normal),
        (name: "Overlay", blendMode: .overlay),
        (name: "Plus Darker", blendMode: .plusDarker),
        (name: "Plus Lighter", blendMode: .plusLighter),
        (name: "Saturation", blendMode: .saturation),
        (name: "Screen", blendMode: .screen),
        (name: "Soft Light", blendMode: .softLight),
        (name: "Source Atop", blendMode: .sourceAtop),
    ]
}


// MARK: - Body
extension BlendModesListView {
    
    var body: some View {
        
        List {
            ForEach(blendModes, id: \.0) { (name, blendMode) in
                
                Section(header: Text(name)) {
                    Image("nebula")
                        .resizable()
                        .scaledToFit()
                        .overlay(
                            Rectangle()
                                .fill(Color.pink)
                                .blendMode(blendMode)
                    )
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
                }
                .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            }
        }
    }
}


// MARK: - Computeds
extension BlendModesListView {
    
    
}


// MARK: - View Variables
extension BlendModesListView {
    
    
}



// MARK: - Preview
struct BlendModesExample_Previews: PreviewProvider {
    
    static var previews: some View {
        BlendModesListView()
    }
}
