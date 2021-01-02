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
    }
}

