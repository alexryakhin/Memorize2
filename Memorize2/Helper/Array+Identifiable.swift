//
//  Array+Identifiable.swift
//  Memorize2
//
//  Created by Alexander Bonney on 4/26/21.
//

import Foundation


extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
