//
//  SetGameView.swift
//  Set Game 2
//
//  Created by Giang Nguyenn on 12/31/20.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel: SetGameVM

    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)

        }
    }
    
    private func body(for size: CGSize) -> some View {
        let numberOfSelectedCard = viewModel.numberOfSelectedCard

        DispatchQueue.main.async {
            if numberOfSelectedCard == 3 {
                if viewModel.check() { withAnimation(.easeInOut(duration: 1)) {
                    viewModel.removeMatch()}
                } else { withAnimation(.easeInOut(duration: 1)) {
                    viewModel.deselectMatch()}
                }
            }
        }

        return VStack {
            Button("New Game") { withAnimation(.easeInOut(duration: 1)) {
                viewModel.resetGame()}}
            Text("score: \((81 - viewModel.cards.count)/3)")
            Grid(items: viewModel.cardsDeal) { card in
                CardView(card: card, numberOfCardSelected: numberOfSelectedCard).onTapGesture {
                        card.isSelected ? viewModel.deselect(card: card) : viewModel.select(card: card)
                }
            }
            .layoutPriority(1)
            CardView(card: SetGameModel.Card(color: .blue, shading: .solid, numberOfShapes: 3, symbol: .circle, id: 100), numberOfCardSelected: 1).onTapGesture { withAnimation(.easeInOut) {
                viewModel.dealCards()
                }
            }.opacity(viewModel.cards.count - viewModel.cardsDeal.count == 0 ? 0.1 : 1)
            .scaleEffect(1.5)
            .padding()
        }
        .font(.largeTitle)
        .onAppear {
            viewModel.removeAllCard()
            withAnimation(.easeInOut(duration: 2)) {viewModel.resetGame()}
        }
    }
}

struct CardView: View {
    var card: SetGameModel.Card
    var numberOfCardSelected: Int
    
    var body: some View {
        VStack {
            ForEach(0 ..< card.numberOfShapes) { shape in
                GeometryReader { geometry in
                    body(for: geometry.size)
                }
            }
        }
        .padding()
        .cardify(isFaceUp: card.isDealt, isSelected: card.isSelected, isMatched: card.isMatched, numberOfSelectedCard: numberOfCardSelected/*, isChecked: card.isChecked*/)
        .foregroundColor(color)
        .transition(.moveAndFlip)
        .padding(5)
        .aspectRatio(2/3, contentMode: .fit)
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            Group {
                if card.symbol.rawValue == 1 {
                    Diamond().stroke(lineWidth: 4)
                    Diamond().fill().opacity(shading)
                } else if card.symbol.rawValue == 2 {
                    Capsule().stroke(lineWidth: 4)
                    Capsule().fill().opacity(shading)
                } else {
                    Rectangle().stroke(lineWidth: 4)
                    Rectangle().fill().opacity(shading)
                }
            }
            .aspectRatio(16/9, contentMode: .fit)
            .frame(width: size.width, height: size.height, alignment: .center)
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
        case.striped: return 0.4
        }
    }
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        SetGameView(viewModel: SetGameVM())
    }
}
