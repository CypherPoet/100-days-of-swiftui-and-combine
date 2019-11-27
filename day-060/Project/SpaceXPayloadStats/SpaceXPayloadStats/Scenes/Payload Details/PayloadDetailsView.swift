//
//  PayloadDetailsView.swift
//  SpaceXPayloadStats
//
//  Created by CypherPoet on 11/23/19.
// ✌️
//

import SwiftUI
import Combine


struct PayloadDetailsView: View {
    private let viewModel: PayloadDetailsViewModel

    
    init(payload: Payload) {
        self.viewModel = PayloadDetailsViewModel(payload: payload)
    }
}


// MARK: - Body
extension PayloadDetailsView {

    var body: some View {
        ZStack {
            backgroundGradient
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(viewModel.payloadNameText)
                    .font(.title)
                    .padding(.bottom, 20)
                    .padding(.top, -20)
                
                HStack {
                    satStats
                        .layoutPriority(2)
                    
                    Spacer()
                        .layoutPriority(1)
                   
                    if viewModel.isShowingApsisLine {
                        apsisTrackView
                            .layoutPriority(1)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
    }
}

// MARK: - Computeds
extension PayloadDetailsView {
}


// MARK: - View Variables
extension PayloadDetailsView {

    private var backgroundGradient: some View {
        GeometryReader { geometry in
            RadialGradient(
                gradient: Gradient(
                    colors: [
                        Color("PayloadDetailsBackground2"),
                        Color("PayloadDetailsBackground1"),
                        Color("PayloadDetailsBackground2"),
                        Color("PayloadDetailsBackground1"),
                        Color("PayloadDetailsBackground2"),
                    ]
                ),
                center: .center,
                startRadius: 1,
                endRadius: max(geometry.size.width, geometry.size.height)
            )
        }
    }
    

    private var satStats: some View {
        VStack(alignment: .leading, spacing: 28.0) {

            if !viewModel.payloadTypeText.isEmpty {
                InfoItem(headerText: "Payload Type", itemText: viewModel.payloadTypeText)
            }
            
            if !viewModel.payloadMassText.isEmpty {
                InfoItem(headerText: "Payload Mass", itemText: viewModel.payloadMassText)
            }
            
            if !viewModel.payloadManufacturerText.isEmpty {
                InfoItem(headerText: "Manufacturer", itemText: viewModel.payloadManufacturerText)
            }

            if !viewModel.payloadNationalityText.isEmpty {
                InfoItem(headerText: "Nationality", itemText: viewModel.payloadNationalityText)
            }

            if !viewModel.payloadOrbitText.isEmpty {
                InfoItem(headerText: "Orbit", itemText: viewModel.payloadOrbitText)
            }
            
            Spacer()
        }
    }
    
    
    private var apsisTrackView: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                
                VStack(spacing: 2) {
                    Text("Periapsis:")
                        .textStyle(InfoHeaderTextStyle(color: Color("Secondary1")))
                    Text(self.viewModel.periapsisText)
                        .fixedSize()
                }
                .padding(.vertical)
                
                RoundedRectangle(cornerRadius: 2, style: .continuous)
                    .fill(Color("Secondary1"))
                    .shadow(color: Color("Secondary1"), radius: 8, x: 0, y: 0)
                    .frame(
                        width: 4.0,
                        height: geometry.size.height * self.viewModel.periapsisPct
                    )
                
                Text("🌎")
                    .scaledSystemFont(size: 32)
                    .padding(.vertical)
                
                RoundedRectangle(cornerRadius: 2, style: .continuous)
                    .fill(Color("Secondary2"))
                    .shadow(color: Color("Secondary2"), radius: 8, x: 0, y: 0)
                    .frame(
                        width: 4.0,
                        height: geometry.size.height * self.viewModel.apoapsisPct
                    )
                
                VStack(spacing: 2) {
                    Text("Apoapsis:")
                        .textStyle(InfoHeaderTextStyle(color: Color("Secondary2")))
                    
                    Text(self.viewModel.apoapsisText)
                        .fixedSize()
                }
                .padding(.vertical)
            }
        }
        .padding(.vertical, 80)
    }
}


// MARK: - Preview
struct PayloadDetailsView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            PayloadDetailsView(payload: SamplePayloads.telstar18V)
                .environment(\.managedObjectContext, SampleMOC.mainContext)
        }
    }
}


private struct InfoItem: View {
    let headerText: String
    let itemText: String
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Text(headerText)
                .fontWeight(.bold)
                .textStyle(InfoHeaderTextStyle(color: Color("LightGray1")))
            
            Text(itemText)
        }
    }
}
