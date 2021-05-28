//
//  Array+Only.swift
//  Memorize2
//
//  Created by Alexander Bonney on 4/26/21.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
