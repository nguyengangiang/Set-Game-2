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
    
    init() {
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
    }
    
    struct Card: Identifiable {
        var color: Color
        var shading: Shading
        var numberOfShapes: Int
        var shape: Shape
        var id: Int
        
        var isMatch: Bool = false
        var isSelected: Bool = false
    }
    
    enum Color: CaseIterable {
        case green
        case blue
        case pink
    }
    
    enum Shading: CaseIterable {
        case solid
        case striped
        case open
    }
    
    enum Shape: CaseIterable {
        case diamond
        case rect
        case circle
    }
}
