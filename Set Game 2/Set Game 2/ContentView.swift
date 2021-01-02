//
//  ContentView.swift
//  Set Game 2
//
//  Created by Giang Nguyenn on 12/31/20.
//

import SwiftUI

struct ContentView: View {
    var viewModel: SetGameVM
    var body: some View {
        Button("New Game", action: viewModel.resetGame)
        Button("Deal cards", action: viewModel.dealCards)
        Grid(items: viewModel.cardsDeal) { card in
            CardView(card: card)
        }
    }
}

struct CardView: View {
    var card: SetGameModel.Card
    
    var body: some View {
        Text("Card") .foregroundColor(color).opacity(shading).cardify(isFaceUp: card.isDealt).padding()
    }
    var color: Color {
        switch card.color {
        case .blue:
            return Color.blue
        case .green:
            return Color.green
        case .pink:
            return Color.pink
        }
    }
    
    var shading: Double {
        switch card.shading {
        case .open: return 0
        case .solid: return 1
        case.striped: return 0.5
        }
    }
}

