//
//  Cardify.swift
//  Memorize
//
//  Created by Giang Nguyenn on 12/30/20.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation: Double
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var isSelected: Bool
    var isMatched: Bool
    var numberOfSelectedCard: Int
    
    var animatableData: Double {
        get {return rotation}
        set {rotation = newValue}
    }
    
    init(isFaceUp: Bool, isSelected: Bool, isMatched: Bool, numberOfSelectedCard: Int) {
        rotation = isFaceUp ? 0 : 180
        self.isSelected = isSelected
        self.isMatched = isMatched
        self.numberOfSelectedCard = numberOfSelectedCard
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group{
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: lineWidth)
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).foregroundColor(Color.purple).opacity(isSelected && numberOfSelectedCard <= 3 ? 0.2 : 0)
                RoundedRectangle(cornerRadius: cornerRadius).opacity((isSelected && numberOfSelectedCard == 3) ? 0.5 : 0.0).foregroundColor(isMatched  ? .green : .red)
                content
            }.opacity(isFaceUp ? 1 : 0)
            RoundedRectangle(cornerRadius: cornerRadius).opacity(isFaceUp ? 0 : 1)
            }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
    private let cornerRadius: CGFloat = 10
    private let lineWidth: CGFloat = 3
}

extension View {
    func cardify(isFaceUp: Bool, isSelected: Bool, isMatched: Bool, numberOfSelectedCard: Int) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp, isSelected: isSelected, isMatched: isMatched, numberOfSelectedCard: numberOfSelectedCard))
    }
}
