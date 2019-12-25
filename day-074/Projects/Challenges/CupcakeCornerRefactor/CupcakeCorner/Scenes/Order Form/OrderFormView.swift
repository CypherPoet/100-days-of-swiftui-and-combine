//
//  OrderFormView.swift
//  CupcakeCorner
//
//  Created by CypherPoet on 11/12/19.
// ✌️
//

import SwiftUI


struct OrderFormView<Destination: View>: View {
    @ObservedObject private(set) var viewModel: OrderFormViewModel
    
    var buildDestination: (() -> Destination)
}


// MARK: - Body
extension OrderFormView {

    var body: some View {
        Form {
            cupcakeSection
            customizationsSection
            
            addressSection
                .disabled(viewModel.isFormValid == false)
        }
    }
}


// MARK: - Computeds
extension OrderFormView {
}


// MARK: - View Variables
extension OrderFormView {
    
    private var cupcakeSection: some View {
        Section(
            header: Text("Cupcake")
                .font(.headline)
        ) {
            Picker("Select A Flavor", selection: $viewModel.selectedFlavorIndex) {
                ForEach(0 ..< Cupcake.Flavor.allCases.count) { index in
                    Text(Cupcake.Flavor.allCases[index].formDisplayText).tag(index)
                }
            }
            
            Stepper(value: $viewModel.cupcakeQuantity, in: 0...24) {
                HStack {
                    Text("Quantity")
                    Spacer()
                    Text("\(viewModel.cupcakeQuantity)")
                }
            }
        }
    }
    

    private var customizationsSection: some View {
        Section(
            header: Text("Customizations")
                .font(.headline)
        ) {
            Toggle(
                isOn: $viewModel.hasSpecialRequest
                    .animation(.easeInOut(duration: 0.4))
            ) {
                Text("Make a special request")
            }
            
            
            if viewModel.hasSpecialRequest {
                Toggle(isOn: $viewModel.wantsExtraFrosting) {
                    Text("Extra Frosting")
                }
                
                Toggle(isOn: $viewModel.addsSprinkles) {
                    Text("Add Sprinkles")
                }
            }
        }
    }
    

    private var addressSection: some View {
        NavigationLink(destination: buildDestination()) {
            Text("Delivery Details")
        }
    }
}



// MARK: - Preview
struct OrderFormView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            OrderFormView(
                viewModel: OrderFormViewModel(),
                buildDestination: { EmptyView() }
            )
        }
    }
}
