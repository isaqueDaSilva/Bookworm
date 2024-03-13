//
//  Icons.swift
//  Bookworm
//
//  Created by Isaque da Silva on 26/02/24.
//

import SwiftUI

/// A custom type to store all the icons that the App uses.
enum Icons: String {
    case person = "person"
    case plus = "plus"
    case trash = "trash"
    case house = "house"
    case pencil = "pencil"
    case chevronLeft = "chevron.left"
    case chevronRight = "chevron.right"
    case bookFill = "book.fill"
    
    /// Returns the selected value of the enum in an image of type SF Symbol, as the representation of the symbol.
    var systemImage: Image {
        Image(systemName: self.rawValue)
    }
}
