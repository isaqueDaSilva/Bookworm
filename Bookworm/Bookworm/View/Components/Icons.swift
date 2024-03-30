//
//  Icons.swift
//  Bookworm
//
//  Created by Isaque da Silva on 26/02/24.
//

import SwiftUI

enum Icons: String {
    case person = "person"
    case plusCircle = "plus.circle"
    case line3 = "line.3.horizontal.decrease.circle"
    case list = "list.bullet"
    case grid = "square.grid.2x2"
    case trash = "trash"
    case house = "house"
    case pencil = "pencil"
    case chevronLeft = "chevron.left"
    case chevronRight = "chevron.right"
    case bookFill = "book.fill"
    case bookVertical = "books.vertical.circle"
    case squareAndPencil = "square.and.pencil"
    
    var systemImage: Image {
        Image(systemName: self.rawValue)
    }
}
