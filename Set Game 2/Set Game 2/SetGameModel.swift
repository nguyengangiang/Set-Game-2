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
                    for symbol in Symbol.allCases {
                        let card = Card(color: color, shading: shading, numberOfShapes: number, symbol: symbol, id: id, isMatched: false, isSelected: false, isDealt: false)
                        id += 1
                        cards.append(card)
                    }
                }
            }
        }
        //cards.shuffle()
        for i in 0 ..< numberOfCardsDealed {
            cards[i].isDealt = true
        }
    }
    
    struct Card: Identifiable {
        var color: Color
        var shading: Shading
        var numberOfShapes: Int
        var symbol: Symbol
        var id: Int
        
        var isMatched: Bool = false
        var isSelected: Bool = false
        var isDealt: Bool = false
        //var isChecked: Bool = false
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
    
    enum Symbol: Int, CaseIterable {
        case diamond = 1
        case rect = 2
        case circle = 3
    }
    
    mutating func select(card: Card) {
        assert(card.isDealt && !card.isMatched && !card.isSelected)
        let index = cards.firstIndex(matching: card)!
        cards[index].isSelected = !cards[index].isSelected
        indicesOfChosenCard.append(index)
    }
    
    mutating func check() -> Bool {
        if indicesOfChosenCard.count == 3 {
            if checkCard() {
                for i in 0..<3 {
                    cards[indicesOfChosenCard[i]].isMatched = true
                    //cards[indicesOfChosenCard[i]].isChecked = true
                    print("\(cards[indicesOfChosenCard[i]])")
                }
                return true
            } 
        }
        return false
    }
    
    mutating func deselectMatch() {
        while (!indicesOfChosenCard.isEmpty) {
            let cardIndex = indicesOfChosenCard[0]
            //cards[cardIndex].isChecked = true
            print("\(cards[cardIndex])")
            deselect(card: cards[cardIndex])
        }
        indicesOfChosenCard.removeAll()
    }
    
    mutating func removeMatch() {
        cards.removeAll { cardIndex in
            cardIndex.isMatched
        }
        indicesOfChosenCard.removeAll()
        dealCards()
    }
    
    func checkCard() -> Bool {
        assert(indicesOfChosenCard.count == 3)
        let card1 = cards[indicesOfChosenCard[0]]
        let card2 = cards[indicesOfChosenCard[1]]
        let card3 = cards[indicesOfChosenCard[2]]
        
        if (card1.numberOfShapes + card2.numberOfShapes + card3.numberOfShapes) % 3 != 0 {
            return false
        }
        if (card1.symbol.rawValue + card2.symbol.rawValue + card3.symbol.rawValue) % 3 != 0 {
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
        assert(card.isDealt && !card.isMatched && card.isSelected && indicesOfChosenCard.count <= 3)
        let index = cards.firstIndex(matching: card)!
        cards[index].isSelected = false
        indicesOfChosenCard = indicesOfChosenCard.filter{$0 != index}
    }
    
    mutating func removeDealtCard(card: Card) {
        cards[cards.firstIndex(matching: card)!].isDealt = false
    }
    
    mutating func removeAllCard() {
        cards.removeAll()
    }
}
