//
//  moveAndFlip.swift
//  Set Game 2
//
//  Created by Giang Nguyenn on 1/8/21.
//

import Foundation
import SwiftUI


extension AnyTransition {
    static var moveAndFlip: AnyTransition {
        let insertion = AnyTransition.move(edge: .bottom)
            .combined(with: .opacity)
        let removal = AnyTransition.move(edge: .bottom)
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}
