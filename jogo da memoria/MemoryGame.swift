//
//  jogo.swift
//  jogo da memoria
//
//  Created by Luan Araujo on 14/03/21.
//

import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    var points: Int
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter{ cards[$0].isFaceUp}.only}
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potetialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potetialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potetialMatchIndex].isMatched = true
                    points += 2
                } else {
                    if cards[chosenIndex].wasSeen {
                        points -= 1
                    } else {
                        cards[chosenIndex].wasSeen = true
                    }
                    if cards[potetialMatchIndex].wasSeen {
                        points -= 1
                    } else {
                        cards[potetialMatchIndex].wasSeen = true
                    }
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    init(numberOfPairs: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairs {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2 + 1))
        }
        cards.shuffle()
        points = 0
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var wasSeen = false
        var content: CardContent
        var id: Int
    }
}
