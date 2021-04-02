//
//  jogo_da_memoriaApp.swift
//  jogo da memoria
//
//  Created by Luan Araujo on 07/03/21.
//

import SwiftUI



@main
struct jogo_da_memoriaApp: App {
    
    var body: some Scene {
        WindowGroup {
            let game = EmojiMemoryGame()
            EmojiContentView(viewModel: game)
        }
    }
}
