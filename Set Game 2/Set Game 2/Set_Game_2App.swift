//
//  Set_Game_2App.swift
//  Set Game 2
//
//  Created by Giang Nguyenn on 12/31/20.
//

import SwiftUI

@main
struct Set_Game_2App: App {
    var body: some Scene {
        WindowGroup {
            SetGameView(viewModel: SetGameVM())
        }
    }
}
