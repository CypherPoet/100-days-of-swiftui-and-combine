//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by CypherPoet on 11/13/19.
// ✌️
//

import SwiftUI
import CypherPoetSwiftUIKit


struct CheckoutView: View {
    @ObservedObject private(set) var viewModel: CheckoutViewModel
    
    var onSubmit: ((Order) -> Void)
}


// MARK: - Body
extension CheckoutView {

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                    
                VStack(spacing: 32.0) {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                
                
                    VStack(spacing: 22) {
                        Text(self.viewModel.orderQuantityText)
                            .font(.largeTitle)
                        
                        Text(self.viewModel.costText)
                            .fontWeight(.bold)
                    }
                    
                    
                    Spacer()
                    
                    
                    Button(action: {
                        self.onSubmit(self.viewModel.order)
                    }) {
                        Text("Checkout")
                            .fontWeight(.bold)
                    }
                    .buttonStyle(CustomFilledButtonStyle(
                        idealWidth: 200,
                        fillColor: .accentColor
                    ))
                }
            }
        }
        .navigationBarTitle("Checkout", displayMode: .inline)
    }
}


// MARK: - Computeds
extension CheckoutView {


}


// MARK: - View Variables
extension CheckoutView {


}



// MARK: - Preview
struct CheckoutView_Previews: PreviewProvider {

    static var previews: some View {
        CheckoutView(
            viewModel: CheckoutViewModel(order: SampleOrder.order1),
            onSubmit: { _ in }
        )
    }
}
