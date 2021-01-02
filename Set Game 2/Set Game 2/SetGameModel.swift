//
//  SetGameModel.swift
//  Set Game 2
//
//  Created by Giang Nguyenn on 1/1/21.
//

import Foundation
import SwiftUI

struct SetGameModel {
    var cards = [Card]()
    var indicesOfChosenCard = [Int]()
    
    init(numberOfCardsDealed: Int) {
        var id = 0
        for color in Color.allCases {
            for shading in Shading.allCases {
                for number in 1...3 {
                    for shape in Shape.allCases {
                        let card = Card(color: color, shading: shading, numberOfShapes: number, shape: shape, id: id)
                        id += 1
                        cards.append(card)
                    }
                }
            }
        }
        cards.shuffle()
        for i in 0 ..< numberOfCardsDealed {
            cards[i].isDealt = false
        }
    }
    
    struct Card: Identifiable {
        var color: Color
        var shading: Shading
        var numberOfShapes: Int
        var shape: Shape
        var id: Int
        
        var isMatched: Bool = false
        var isSelected: Bool = false
        var isDealt: Bool = false
    }
    
    enum Color: Int, CaseIterable {
        case green = 1
        case blue = 2
        case pink = 3
    }
    
    enum Shading: Int, CaseIterable {
        case solid = 1
        case striped = 2
        case open = 3
    }
    
    enum Shape: Int, CaseIterable {
        case diamond = 1
        case rect = 2
        case circle = 3
    }
    
    mutating func select(card: Card) {
        assert(card.isDealt && !card.isMatched && !card.isSelected)
        let index = cards.firstIndex(matching: card)!
        cards[index].isSelected = true
        indicesOfChosenCard.append(index)
    }
    
    private func check() -> Bool {
        assert(indicesOfChosenCard.count == 3)
        let card1 = cards[indicesOfChosenCard[1]]
        let card2 = cards[indicesOfChosenCard[2]]
        let card3 = cards[indicesOfChosenCard[3]]
        
        if (card1.numberOfShapes + card2.numberOfShapes + card3.numberOfShapes) % 3 != 0 {
            return false
        }
        if (card1.shape.rawValue + card2.shape.rawValue + card3.shape.rawValue) % 3 != 0 {
            return false
        }
        if (card1.color.rawValue + card2.color.rawValue + card3.color.rawValue) % 3 != 0 {
            return false
        }
        if (card1.shading.rawValue + card2.shading.rawValue + card3.shading.rawValue) % 3 != 0 {
            return false
        }
        return true
    }
    
    mutating func dealCards(amount: Int = 3) {
        let indicesOfCardsInDeck = cards.indices.filter{cards[$0].isDealt == false}.shuffled()
        if indicesOfCardsInDeck.count < amount {return }
        for i in 0 ..< amount {
            let index = indicesOfCardsInDeck[i]
            cards[index].isDealt = true
        }
    }
    
    mutating func deselect(card: Card) {
        assert(card.isDealt && !card.isMatched && card.isSelected && indicesOfChosenCard.count < 3)
        let index = cards.firstIndex(matching: card)!
        cards[index].isSelected = false
        indicesOfChosenCard = indicesOfChosenCard.filter{$0 != index}
    }
}
