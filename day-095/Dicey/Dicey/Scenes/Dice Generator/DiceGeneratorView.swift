//
//  DiceGeneratorView.swift
//  Dicey
//
//  Created by CypherPoet on 2/2/20.
// ✌️
//

import SwiftUI


struct DiceGeneratorView {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    private let diceCountRange = 1...6
    private let diceRollAnimationDuration = 0.76
    
    
    @ObservedObject var viewModel: ViewModel
    let onDiceRolled: (([Dice]) -> Void)?
    
    @State private var isShakingDice = false
    @State private var isShowingDice = true
    @State private var isShakeButtonEnabled = true
    
    @State private var diceRollCompletion: CGFloat = 1.0
}



// MARK: - View
extension DiceGeneratorView: View {

    var body: some View {
        VStack(spacing: 40) {
            Group {
                if isShowingDice {
                    diceCollectionSection
                } else {
                    Color.clear
                }
            }
            
            VStack(spacing: 12) {
                rollButton
                controlPanel
            }
        }
    }
}



// MARK: - Computeds
extension DiceGeneratorView {
    
    var isShowingHorizontalDiceLayout: Bool {
        horizontalSizeClass == .regular && verticalSizeClass == .compact
    }
    
    
    var diceRollAnimation: Animation {
        Animation.spring(
            response: diceRollAnimationDuration,
            dampingFraction: 0.635,
            blendDuration: 0.0
        )
    }
    
    
    var diceRollRotation: Angle {
        .radians(
            (1.0 - Double(self.diceRollCompletion))
            * (.pi * Double.random(in: 0...1))
        )
    }
  
    
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
                    HorizontalDiceRollView(diceCollection: self.viewModel.rollResults)
                } else {
                    VerticalDiceRollView(diceCollection: self.viewModel.rollResults) { (index, dice, position, sideLength) in
                        DiceView(dice: dice)
                            .frame(
                                width: sideLength,
                                height: sideLength
                            )
                            .position(position)
                            .rotationEffect(self.diceRollRotation, anchor: .center)
                            .offset(
                                x: 0,
                                y: (
                                    (-1.0 * (1.0 - self.diceRollCompletion) * CGFloat(geometry.size.height))
                                    - ((1.0 - self.diceRollCompletion) * position.y)
                                )
                            )
                    }
                }
            }
            .offset(self.offsetFromShake(in: geometry))
        }
    }

    
    private var rollButton: some View {
        Button(action: {
            self.isShakeButtonEnabled = false
            
            // Shake the current set
            withAnimation(
                Animation
                    .timingCurve(0.3, 0.3, 0.7, 2.7, duration: 0.11)
                    .repeatCount(8, autoreverses: true)
            ) {
                self.isShakingDice = true
            }
            
            // Roll in the new set
            DispatchQueue.main.asyncAfter(deadline: .now() + (0.11 * 8)) {
                self.isShakingDice = false
                self.isShowingDice = false
                self.diceRollCompletion = 0.0
                self.onDiceRolled?(self.viewModel.generateRollResults())
                
                DispatchQueue.main.async {
                    self.isShowingDice = true
                    
                    withAnimation(self.diceRollAnimation) {
                        self.diceRollCompletion = 1.0
                        self.isShakeButtonEnabled = true
                    }
                }
            }
        }) {
            Image("roll-dice")
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .padding()
                .background(Color.accentColor)
                .clipShape(Circle())
                .shadow(color: .gray, radius: 4, x: 0, y: 0)
        }
        .disabled(isShakeButtonEnabled == false)
    }
    
    
    private var controlPanel: some View {
        Form {
            HStack {
                Text("Dice Count")
                
                Spacer()
                
                Text("\(viewModel.diceCount)")

                Stepper("Dice Count", value: $viewModel.diceCount, in: diceCountRange)
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
                diceCount: 2
            ),
            onDiceRolled: { _ in }
        )
    }
}
