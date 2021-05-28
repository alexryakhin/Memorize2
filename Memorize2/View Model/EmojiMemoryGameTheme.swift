//
//  EmojiMemoryGameTheme.swift
//  Memorize2
//
//  Created by Alexander Bonney on 5/1/21.
//

import Foundation
import SwiftUI

struct EmojiMemoryGameTheme: Identifiable {
    var id: Int
    
    var name: String
    var content: [String]
    var color: UIColor
    var numberOfPairs: Int
    
    var color1: Color {
        Color(color)
    }
    
    init(id: Int, name: String, content: [String], color: UIColor, numberOfPairs: Int) {
        self.id = id
        self.name = name
        self.content = content
        self.color = color
        self.numberOfPairs = numberOfPairs
    }
    
}
