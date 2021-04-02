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
                    RoundedRectangle(cornerRadius:5).fill(Color.gray).aspectRatio(10/1, contentMode: .fit)
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
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if card.isFaceUp {
                    RoundedRectangle(cornerRadius:cornerRadius).fill(Color.white)
                    RoundedRectangle(cornerRadius:cornerRadius).stroke(lineWidth: edgeLineWidth)
                    Text(card.content)
                } else {
                    if !card.isMatched {
                        RoundedRectangle(cornerRadius:cornerRadius).fill()
                    }
                }
            }
            .font(Font.system(size: fontSize(for: geometry.size)))
            .padding(paddingSize)
        }
    }
    
    // MARK: - Drawing Constants
    let paddingSize: CGFloat = 5
    let cornerRadius: CGFloat = 10
    let edgeLineWidth: CGFloat = 3
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiContentView(viewModel: EmojiMemoryGame())
    }
}

