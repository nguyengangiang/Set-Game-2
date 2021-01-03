//
//  Diamond.swift
//  Set Game 2
//
//  Created by Giang Nguyenn on 1/2/21.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let left = CGPoint(x: 0, y: rect.midY)
        let top = CGPoint(x: rect.midX, y: 0)
        let right = CGPoint(x: rect.width, y: rect.midY)
        let bottom = CGPoint(x:rect.midX, y: rect.height)
        path.move(to: left)
        path.addLine(to: top)
        path.addLine(to: right)
        path.addLine(to: bottom)
        path.addLine(to: left)
        return path
    }
}
