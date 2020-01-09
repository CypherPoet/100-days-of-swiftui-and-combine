//
//  ContextMenuExample.swift
//  Project16Concepts
//
//  Created by CypherPoet on 1/9/20.
// ✌️
//

import SwiftUI


struct ContextMenuExample: View {
    @State private var currentColor = Color.purple
}


// MARK: - Body
extension ContextMenuExample {

    var body: some View {
        VStack(spacing: 42) {
            
            VStack {
                Text(currentColor.description.capitalized)
                    .font(.title)
                    .foregroundColor(currentColor)
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(currentColor)
                    .frame(height: 100)
            }
            
            Text("🎨")
                .font(.title)
                .padding()
                .background(Color.black)
                .cornerRadius(.infinity)
                .contextMenu { colorMenuItems }
            
        }
        .navigationBarTitle("Context Menus")
    }
    
}


// MARK: - Computeds
extension ContextMenuExample {
}


// MARK: - View Variables
extension ContextMenuExample {


    private var colorMenuItems: some View {
        VStack {
            Button(
                action: { self.currentColor = .red },
                label: {
                    Text("Red")
                    Image(systemName: "largecircle.fill.circle").foregroundColor(.red)
                }
            )
            
            Button(
                action: { self.currentColor = .purple },
                label: {
                    Text("Purple")
                    Image(systemName: "largecircle.fill.circle").foregroundColor(.purple)
                }
            )
            
            Button(
                action: { self.currentColor = .pink },
                label: {
                    Text("Pink")
                    Image(systemName: "largecircle.fill.circle").foregroundColor(.pink)
                }
            )
            
            Button(
                action: { self.currentColor = .yellow },
                label: {
                    Text("Yellow")
                    Image(systemName: "largecircle.fill.circle").foregroundColor(.yellow)
                }
            )
        }
    }
}



// MARK: - Preview
struct ContextMenuExample_Previews: PreviewProvider {

    static var previews: some View {
        ContextMenuExample()
    }
}
