//
//  DiceGeneratorView.swift
//  Dicey
//
//  Created by CypherPoet on 2/2/20.
// ✌️
//

import SwiftUI


struct DiceGeneratorView {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    private let diceCountRange = 1...6
    
    @ObservedObject var viewModel: ViewModel
    let onDiceRolled: ((DiceRoll) -> Void)?
    
//    @State private var diceShakeCompletionPercentage: CGFloat = 0.0
    @State private var hasDiceRolledAtLeastOnce = false
    @State private var isShakingDice = false
    @State private var diceCollectionViewID = 1
    @State private var isShowingDice = true
}



// MARK: - View
extension DiceGeneratorView: View {

    var body: some View {
        VStack(spacing: 20) {
            
            if isShowingDice {
                diceCollectionSection
//                    .id(self.diceCollectionViewID)
                    .transition(self.diceCollectionTransition)
            } else {
                Color.clear
            }
            
            rollButton
            
            controlPanel
        }
    }
}



// MARK: - Computeds
extension DiceGeneratorView {
    
    var isShowingHorizontalDiceLayout: Bool {
        horizontalSizeClass == .regular && verticalSizeClass == .compact
    }
    
    
    var diceCollectionTransition: AnyTransition {
        .asymmetric(
            insertion: AnyTransition
                .move(edge: .bottom).combined(with: .scale(scale: 0, anchor: .top)),
            removal: AnyTransition
                .opacity
        )
    }
  
    
    // TODO: Improve this logic
    func offsetFromShake(in geometry: GeometryProxy) -> CGSize {
        .init(
            width: isShakingDice ? geometry.size.width / 2 : 0,
            height: 0
        )
    }
}



// MARK: - View Variables
extension DiceGeneratorView {
    
    private var diceCollectionSection: some View {
        GeometryReader { geometry in
            Group {
                if self.isShowingHorizontalDiceLayout {
                    HorizontalDiceRollView(diceCollection: self.viewModel.diceCollection)
                } else {
                    VerticalDiceRollView(diceCollection: self.viewModel.diceCollection)
                }
            }
            .offset(self.offsetFromShake(in: geometry))
        }
    }
    

    
    private var rollButton: some View {
        Button(action: {
//            self.onDiceRolled?(viewModel.diceRollFromForm)
            self.hasDiceRolledAtLeastOnce = true
            
            withAnimation(
                Animation
                    .timingCurve(0.3, 0.3, 0.7, 2.7, duration: 0.07)
                    .repeatCount(10, autoreverses: true)
            ) {
                self.isShakingDice = true
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + (0.07 * 10)) {
//                self.diceCollectionViewID += 1
                self.isShakingDice = false
                self.isShowingDice = false
                
                DispatchQueue.main.async {
                    withAnimation(.linear(duration: 2)) {
                        self.isShowingDice = true
                    }
                }
//                self.isShowingDice = true
            }
        }) {
            Image("roll-dice")
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .padding()
                .background(Color.accentColor)
                .clipShape(Circle())
                .shadow(color: .gray, radius: 4, x: 0, y: 0)
        }
        .disabled(isShakingDice)
    }
    
    
    private var controlPanel: some View {
        Form {
            HStack {
                Text("Dice Count")
                
                Spacer()
                
                Text("\(viewModel.diceCount)")
                Stepper("Dice Count", value: viewModel.$diceCount, in: diceCountRange)
                    .labelsHidden()
            }
        }
    }
}



// MARK: - Private Helpers
private extension DiceGeneratorView {
    
    
}



// MARK: - Preview
struct DiceGeneratorView_Previews: PreviewProvider {

    static var previews: some View {
        DiceGeneratorView(
            viewModel: .init(
                diceCount: .constant(2)
            ),
            onDiceRolled: { _ in }
        )
    }
}
