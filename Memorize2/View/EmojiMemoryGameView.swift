//
//  EmojiMemoryGameView.swift
//  Memorize2
//
//  Created by Alexander Bonney on 4/18/21.
//

import SwiftUI

//If the second thing in a view is a curly brace thing, you could get rid of the label. And if I have no arguments in some view, for example ZStack - I got rid of content: label and there are empty parantheses () - I can defenetely get rid of those too.

//Our Grid is gonna have a simple view, and it's gonna replicate using ForEach exactly the same way as ForEach to put a certain view in each spot in a row and column. Our Grid is gonna combine HStack with ForEach. We are gonna take an array of identifiable things like our viewModel.cards and we are going to pass a function that takes one argument as one element in this grid and then returns the View to draw this element like ForEach does. 

struct EmojiMemoryGameView: View {
    @ObservedObject  var viewModel: EmojiMemoryGame
    
    
    //this var body has to be non-private because the system is going to access this var.
    var body: some View {
        NavigationView {
            VStack {
                Grid(viewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                        withAnimation(.linear) {
                            viewModel.choose(card: card)
                        }
                    }
                    .padding(8)
                }
                .foregroundColor(EmojiMemoryGame.randomTheme.color1)
                
                Text("Score: ")
                    .font(.title)
            }
            .padding()
            .navigationBarTitle("\(EmojiMemoryGame.randomTheme.name)")
            .navigationBarItems(trailing: Button(action: {
                withAnimation(.easeInOut) {
                    viewModel.startNewGame()
                }
            }, label: {
                Text("New game")
                    .font(.headline)
                    .bold()
            }))
        }
        
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    @ViewBuilder
    var body: some View {
        //GeometryReader helps us to choose optimal font size which fits inside of our cards. So it has this geometry property, and we are using its size property to calculate our font size. You can see that in ".font" modifier. And we also added this 0.75 in purpose that text inside our card should have some space around it.
        GeometryReader { geometry in
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise: true)
                        .padding(5).opacity(0.35)
                    Text(card.content).font(.system(size: min(geometry.size.width, geometry.size.height) * fontScaleFactor))
                }
                .cardify(isFaceUp: card.isFaceUp)
                .transition(AnyTransition.scale)
            }
        }
    }
    //MARK: - Drawing Constants
    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3
    private let fontScaleFactor: CGFloat = 0.7
    
}
























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
