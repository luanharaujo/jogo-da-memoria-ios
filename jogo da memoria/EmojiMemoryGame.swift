//
//  MemoriaEmoji.swift
//  jogo da memoria
//
//  Created by Luan Araujo on 14/03/21.
//

import SwiftUI

let themes = [
    (name: "Halloween", emojis: ["π»","π","π","π·","πΈ"],color: Color.orange),
    (name: "Tech", emojis: ["π»","π±","π₯","π·","βοΈ"],color: Color.init(red: 0.1, green: 0.1, blue: 0.1, opacity: 1)),
    (name: "Vintage", emojis: ["π½","πΊ","π»","π°","π‘"],color: Color.init(red: 0.6, green: 0.4, blue: 0.2, opacity: 1)),
    (name: "Food", emojis: ["π","π¦","π§","π©","πͺ"],color: Color.yellow),
    (name: "Art", emojis: ["πͺ","π€ΉπΎββοΈ","π­","πͺ","π€ΈπΌββοΈ"],color: Color.red),
    (name: "Middle-earth", emojis: ["πΉ","π°","π§ββοΈ","π","π‘"],color: Color.gray)
]

var chosenTheme: Int = 0

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    
    
    static func createMemoryGame() -> MemoryGame<String> {
        chosenTheme = Int.random(in: 0..<themes.count)
        let emojis = themes[chosenTheme].emojis.shuffled()
        return MemoryGame<String>(numberOfPairs:Int.random(in: 2...5)) {
            pairIndex in
                return emojis[pairIndex]
        }
    }
    
    // MARK: - Access to the Madel
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var color: Color {
        themes[chosenTheme].color
    }
    
    var themeName: String {
        themes[chosenTheme].name
    }
    
    var points: Int {
        model.points
    }
    
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}


