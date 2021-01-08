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
        GeometryReader { geometry in
            body(for: geometry.size)

        }
    }
    
    private func body(for size: CGSize) -> some View {
        let numberOfSelectedCard = viewModel.numberOfSelectedCard

        DispatchQueue.main.async { withAnimation(.easeInOut(duration: 1)) {
            if numberOfSelectedCard == 3 {
                Thread.sleep(forTimeInterval: 0.2)
                viewModel.check()
                }
            }
        }
        return VStack {
            Button("New Game") { withAnimation(.easeInOut(duration: 1)) {
                viewModel.resetGame()}}.transition(.offset())
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
            }
        }
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
        .cardify(isFaceUp: card.isDealt, isSelected: card.isSelected)
        .foregroundColor(color)
        .transition(.offset(x: 0, y: 1000))
        .padding()
        .aspectRatio(2/3, contentMode: .fit)
    }
    
    func body(for size: CGSize) -> some View {
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
        case.striped: return 0.5
        }
    }
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: SetGameVM())
    }
}
