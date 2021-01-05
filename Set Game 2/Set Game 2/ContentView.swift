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
        VStack {
            Button("New Game") { withAnimation(.easeInOut) {
                viewModel.resetGame()}}.transition(.offset())
            Grid(items: viewModel.cardsDeal) { card in
                CardView(card: card).onTapGesture{ withAnimation(.easeInOut) {card.isSelected ? viewModel.deselect(card: card) : viewModel.select(card: card)}}
                    .transition(.slide)
            }
            .layoutPriority(1)
            CardView(card: SetGameModel.Card(color: .blue, shading: .solid, numberOfShapes: 3, symbol: .circle, id: 100)).foregroundColor(.red).onTapGesture { withAnimation(.easeInOut) {
                viewModel.dealCards()
                }
            }
            .transition(.offset(x: 100, y: -100))
        }
        .onAppear { withAnimation(.linear(duration: 1)) {
            viewModel.resetGame()}
        }.transition(.offset(x: CGFloat(Int.random(in: 10...150)), y: CGFloat(Int.random(in: 10...150))))
    }
}

struct CardView: View {
    var card: SetGameModel.Card
    
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
        .padding(5)
        .foregroundColor(color)
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
