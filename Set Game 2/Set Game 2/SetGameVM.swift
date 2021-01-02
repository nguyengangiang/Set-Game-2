//
//  SetGameVM.swift
//  Set Game 2
//
//  Created by Giang Nguyenn on 1/1/21.
//

import Foundation

class SetGameVM {
    private var model: SetGameModel = newGame(numberOfCardsDealt: 12)
    
    static func newGame(numberOfCardsDealt: Int) -> SetGameModel{
        SetGameModel(numberOfCardsDealed: 12)
    }
    
    // MARK: Intents
    func resetGame() {
        model = SetGameVM.newGame(numberOfCardsDealt: 12)
    }
    
    func select(card: SetGameModel.Card) {
        model.select(card: card)
    }
    
    func deselect(card: SetGameModel.Card) {
        model.deselect(card: card)
    }
    
    func dealCards() {
        model.dealCards(amount: 3)
    }
    
    // MARK: Access to Model
    var cards: Array<SetGameModel.Card> {
        model.cards
    }
    
    var cardOnScreen: Array<SetGameModel.Card> {
        print("cards on screen: \(model.cards.filter{$0.isDealt && !$0.isMatched})")
        return model.cards.filter{$0.isDealt && !$0.isMatched}
    }
    
    var cardsDeal: Array<SetGameModel.Card> {
        print("cards dealt: \(model.cards.filter{$0.isDealt})")
        return model.cards.filter{$0.isDealt}
    }
}