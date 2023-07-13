//
//  Concentration.swift
//  Concentration App
//
//  Created by Pedro Henrique Lopes Duca on 11/07/23.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    var theme: [String]
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    var allCardsFaceUp: Bool {
        return cards.allSatisfy { $0.isFaceUp }
    }
    
    func chooseCard(at index: Int){
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 card are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        updateEmoji()
    }
    
    private func updateEmoji() {
        var emoji = [Int: String]()
        if !theme.isEmpty {
            for index in cards.indices {
                let card = cards[index]
                emoji[card.identifier] = theme[index % theme.count]
            }
        }
        for index in cards.indices {
            cards[index].emoji = emoji[cards[index].identifier] ?? "?"
        }
    }
    
    init(numberOfPairsOfCards: Int, theme: [String]){
        self.theme = theme
        
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
            cards.shuffle()
        }
    }
}
