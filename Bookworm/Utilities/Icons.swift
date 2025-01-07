//
//  Icons.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/2/25.
//

import SwiftUI

enum Icons: String {
    case bookVertical = "books.vertical.circle"
    case trash = "trash"
    case list = "list.bullet"
    case grid = "square.grid.2x2"
    case bookFill = "book.fill"
    case plusCircle = "plus.circle"
    case star = "star.fill"
    case chevronRight = "chevron.right"
    case chevronLeft = "chevron.left"
    case squareAndPencil = "square.and.pencil"
    case person = "person"
    case pencil = "pencil"
    case magnifyingglass = "magnifyingglass"
    
    var systemImage: Image {
        Image(systemName: self.rawValue)
    }
}
