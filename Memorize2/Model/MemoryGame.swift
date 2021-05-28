//
//  MemoryGame.swift
//  Memorize2
//
//  Created by Alexander Bonney on 4/19/21.
//
// This is my Model, it knows how to play our Memory Game. When we create a model, we should ask ourselves what does our Model do?

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    // we need an array of cards, and we also need a way to choose a card.
    private(set) var cards: Array<Card>
    
    //we need to know it there is one and only one face up card or not, so  for this purpose we create this var
    /*
    And there will be another execution of this code in just one line!
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        //we are getting from the card this index
        get {
            var faceUpCardIndices = Array<Int>()
            for index in cards.indices {
                if cards[index].isFaceUp {
                    faceUpCardIndices.append(index)
                }
            }
            if faceUpCardIndices.count == 1 {
                return faceUpCardIndices.first
            } else {
                return nil
            }
        }
        //and if someone sets this index, we would flip all our other cards face down, but if the index is equal newValue, those two cards would be face up.
        set {
            for index in cards.indices {
                if index == newValue {
                    cards[index].isFaceUp = true
                 } else {
                    cards[index].isFaceUp = false
                }
            }
        }
    }
    */
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter { cards[$0].isFaceUp }.only
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    // inside this function we are gonna have all the logic for our game matching cards. it can't be private because people should know how to play our game
    mutating func choose(card: Card) {
        // if let syntax is called optional binding.
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isMatched {
            // only choose cards that are unmatched
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard, potentialMatchIndex != chosenIndex {
                // can't choose the same card twice
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    // here is a match case
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    //init can't be private also
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = [Card]()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
            
        }
        cards.shuffle()
    }
    
    //this struct can be private, but the only way that i can access to this struct is through the cards array that is already private. so we just don't want our struct to be private, and that will be perfectly fine.
    struct Card: Identifiable {
        //This Card should represent a single card. The third var "content" is what's on the card. It has generic "dont care" type - CardContent. To use this type, first - I have to declare it in <> in the name of my main struct. And then I am able to use it in my context. This type depends what is in the content. It can represent String, Int, Double, etc.
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
