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
                    viewModel.choose(card: card)
                }
                //.aspectRatio(2/3, contentMode: .fit)
            }.padding().foregroundColor(viewModel.color)
            HStack {
                Text("Points: \(viewModel.points)")
                ZStack {
                    RoundedRectangle(cornerRadius:5).fill(Color.gray).aspectRatio(8/1, contentMode: .fit)
                    Text("New Game")
                }.onTapGesture {
                    viewModel.newGame()
                }
                
            }
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    @ViewBuilder
    var body: some View {
        GeometryReader { geometry in
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(20), clockWise: true)
                        .padding(5)
                        .opacity(0.4)
                    Text(card.content).font(Font.system(size: fontSize(for: geometry.size)))
                }
                .cardify(isFaceUp: card.isFaceUp)
                .padding(paddingSize)
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

