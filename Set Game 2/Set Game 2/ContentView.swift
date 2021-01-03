//
//  ContentView.swift
//  Set Game 2
//
//  Created by Giang Nguyenn on 12/31/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: SetGameVM
    var body: some View {
        Button("New Game", action: viewModel.resetGame)
        Button("Deal cards", action: viewModel.dealCards)
        Grid(items: viewModel.cardsDeal) { card in
            CardView(card: card).onTapGesture{card.isSelected ? viewModel.deselect(card: card) : viewModel.select(card: card)}
        }
    }
}

struct CardView: View {
    var card: SetGameModel.Card
    
    var body: some View {
        VStack {
            ForEach(0 ..< card.numberOfShapes) { shape in
                GeometryReader { geometry in
                    ZStack {
                        Group {
                            if card.symbol.rawValue == 1 {
                                Diamond().stroke(lineWidth: 2)
                                Diamond().fill().opacity(shading)
                            } else if card.symbol.rawValue == 2 {
                                Capsule().stroke(lineWidth: 2)
                                Capsule().fill().opacity(shading)
                            } else {
                                Rectangle().stroke(lineWidth: 2)
                                Rectangle().fill().opacity(shading)
                            }
                        }
                        .aspectRatio(16/9, contentMode: .fit)
                        .padding(CGFloat(20 / card.numberOfShapes))
                    }
                    .frame(width: geometry.size.width,
                           height: geometry.size.height / CGFloat(card.numberOfShapes),
                           alignment: .center)
                    .position(x: geometry.size.width / 2,
                              y: geometry.size.height * CGFloat(shape) / (CGFloat(card.numberOfShapes)) + geometry.size.height / CGFloat(2 * card.numberOfShapes))
                }
            }
            .cardify(isFaceUp: card.isDealt)
            .padding()
            .foregroundColor(color)

        }
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

