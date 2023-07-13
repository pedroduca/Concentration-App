//
//  Card.swift
//  Concentration App
//
//  Created by Pedro Henrique Lopes Duca on 11/07/23.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    var emoji: String
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
        self.emoji = ""
    }
}
