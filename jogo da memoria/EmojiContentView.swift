//
//  EmojiContentView.swift
//  jogo da memoria
//
//  Created by Luan Araujo on 07/03/21.
//

import SwiftUI

struct EmojiContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text(viewModel.themeName).font(Font.largeTitle)
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear) {
                        viewModel.choose(card: card)
                    }
                }
                //.aspectRatio(2/3, contentMode: .fit)
            }.padding().foregroundColor(viewModel.color)
            HStack {
                Text("Points: \(viewModel.points)")
                Button(action: {
                    withAnimation(.easeInOut) {
                        viewModel.newGame()
                    }
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius:5).fill(viewModel.color).aspectRatio(8/1, contentMode: .fit)
                        Text("New Game").foregroundColor(Color.white) //como inverter a cor do tema?
                    }
                })
            }
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation () {
        animatedBonusRemaining = card.bunusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    var body: some View {
        GeometryReader { geometry in
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    Group {
                        if card.isConsumingBonusTime {
                            Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-animatedBonusRemaining*360 - 90), clockWise: true)
                                .onAppear() {
                                    self.startBonusTimeAnimation()
                                }
                        } else {
                            Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-card.bunusRemaining*360 - 90), clockWise: true)
                        }
                    }
                        .padding(5)
                        .opacity(0.4)
                        .transition(.identity)
                    Text(card.content).font(Font.system(size: fontSize(for: geometry.size)))
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                        .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
                }
                .cardify(isFaceUp: card.isFaceUp)
                .padding(paddingSize)
                .transition(AnyTransition.scale)
            }
        }
    }
    
    // MARK: - Drawing Constants
    private let paddingSize: CGFloat = 5
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.70
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiContentView(viewModel: EmojiMemoryGame())
    }
}

