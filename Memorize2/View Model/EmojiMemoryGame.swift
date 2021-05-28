//
//  EmojiMemoryGame.swift
//  Memorize2
//
//  Created by Alexander Bonney on 4/19/21.
//
// This is my ViewModel. It glues my Model - totally UI independent thing with my View - totally UI dependent thing. ViewModel is a class. And we can use import SwiftUI here, even if we are not using UI things here.

// ViewModel is essentially a portal between the Views and our Model.


import SwiftUI

class EmojiMemoryGame: ObservableObject {
    //class is object-oriented thing.
    //I create the var model, which is kinda bad name for this thing, and I should use the name "game", or something like this. We call this thing a model because this var accesses our Model. And this var has a type of our Model struct. And we make our var private - that means only EmojiMemoryGame has access to it. Then we create the same array "cards"
    
    @Published private var model: MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCards: randomTheme.numberOfPairs) { randomTheme.content[$0] }
    
    private static let themes: [EmojiMemoryGameTheme] = [
        EmojiMemoryGameTheme(id: 0, name: "Halloween", content: ["🎃","👻","💀","🕷","🧟","🕯"], color: .orange, numberOfPairs: 6),
        EmojiMemoryGameTheme(id: 1, name: "Cars", content: ["🚗","🚕","🚌","🏎","🚓","🚑"], color: .blue, numberOfPairs: 6),
        EmojiMemoryGameTheme(id: 2, name: "Flags", content: ["🇺🇸","🇨🇦","🇳🇱","🇸🇪","🇫🇷","🇩🇪"], color: .red, numberOfPairs: 6),
        EmojiMemoryGameTheme(id: 3, name: "Weather", content: ["☀️","☁️","🌧","❄️","🌪","🌙"], color: #colorLiteral(red: 1, green: 0.8704642057, blue: 0, alpha: 1), numberOfPairs: 6),
        EmojiMemoryGameTheme(id: 4, name: "Fruit", content: ["🍎","🍇","🥑","🌶","🧄","🥥"], color: .green, numberOfPairs: 6),
        EmojiMemoryGameTheme(id: 5, name: "Music", content: ["🎺","🎷","🎻","🎸","🎹","🎤"], color: .purple, numberOfPairs: 6)
    ]

    private static let randomNumber = Int.random(in: 0..<themes.count)
    private(set) static var randomTheme = themes[randomNumber]
    
    //MARK: Access to the Model
    //This doesn't have to be private, because it read-only anyway
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    //MARK: Intents
    //Our intents have to be public
    //Here Im gonna provide some functions to allow the View to access the Model. We are gonna create the same choose method.
     
    func choose(card: MemoryGame<String>.Card ) {
//        objectWillChange.send()
        model.choose(card: card)
    }
    
    func startNewGame() {
        let randomNumber = Int.random(in: 0..<EmojiMemoryGame.themes.count)
        EmojiMemoryGame.randomTheme = EmojiMemoryGame.themes[randomNumber]
        
        model = MemoryGame<String>(numberOfPairsOfCards: EmojiMemoryGame.randomTheme.numberOfPairs) {
            EmojiMemoryGame.randomTheme.content[$0]
        }
    }
    
}
