//
//  Grid.swift
//  Memorize2
//
//  Created by Alexander Bonney on 4/26/21.
//
//  Our Grid is completely generic.
//  Grid should contain two arguments. First - Our array of identifiable things and Second is a function that takes one element from an array and passes it into a spot. Item and ItemView are "don't care" generic types that could be everything like text, image or any view.

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    //if we have the init that sets our vars in a struct, we could make our vars to be fully private
    private var items: [Item]
    private var viewForItem: (Item) -> ItemView
    
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    
    var body: some View {
        // We need to figure out how much space we need to locate our items, so we are gonna use GeometryReader for this purpose.
        
        GeometryReader { geometry in
            body(for: GridLayout(itemCount: items.count, in: geometry.size))
        }
    }
    
    func body(for layout: GridLayout) -> some View {
        ForEach(items) { item in
            body(for: item, in: layout)
        }
    }
    
    func body(for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(matching: item)!
        return viewForItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index))
    }
}
 
