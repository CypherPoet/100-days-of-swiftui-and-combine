//

//  CardView.swift
//  Flashzilla
//
//  Created by CypherPoet on 1/19/20.
// ✌️
//

import SwiftUI
import CypherPoetSwiftUIKit
import CypherPoetSwiftUIAnimationKit


struct CardView {
    @ObservedObject var viewModel: ViewModel

    @State private var isShowingAnswer = false
}


// MARK: - View
extension CardView: View {

    
    var body: some View {
        ZStack {
            cardBackground
            cardContent
        }
        .onTapGesture {
            withMotionSensitiveAnimation(Animation.easeInOut(duration: 0.3)) {
                self.isShowingAnswer.toggle()
            }
        }
    }
}


// MARK: - Computeds
extension CardView {
}


// MARK: - View Variables
extension CardView {
    
    private var cardBackground: some View {
        GeometryReader { geometry in
            RoundedRectangle(
                cornerRadius: min(geometry.size.width, geometry.size.height) * 0.08,
                style: .continuous
            )
            .fill(Color("CardBackground"))
            .shadow(
                color: Color.gray.opacity(0.8),
                radius: min(geometry.size.width, geometry.size.height) * 0.02,
                x: 0,
                y: min(geometry.size.width, geometry.size.height) * 0.01
            )
        }
    }
    
    
    private var cardContent: some View {
        VStack {
            Text(viewModel.cardPromptText)
                .font(.largeTitle)
                .foregroundColor(Color("Accent2"))
            
            if isShowingAnswer {
                Text(viewModel.cardAnswerText)
                    .font(.title)
                    .foregroundColor(Color("Accent1"))
            }
        }
        .padding(20)
        .multilineTextAlignment(.center)
    }
}


// MARK: - Private Helpers
private extension CardView {
}


// MARK: - Preview
struct CardView_Previews: PreviewProvider {

    static var previews: some View {
        let context = CurrentApp.coreDataManager.mainContext
        
        return VStack {
            CardView(
                viewModel: .init(
                    card: PreviewData.Cards.default
                )
            )
            .padding()
        }
        .environment(\.managedObjectContext, context)
        .previewLayout(PreviewLayout.iPhone11Landscape)
    }
}
