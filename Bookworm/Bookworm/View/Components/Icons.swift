//
//  Icons.swift
//  Bookworm
//
//  Created by Isaque da Silva on 26/02/24.
//

import SwiftUI

enum Icons: String {
    case person = "person"
    case envelope = "envelope"
    case key = "key"
    case eye = "eye"
    case eyeSlash = "eye.slash"
    case plus = "plus"
    case trash = "trash"
    case house = "house"
    case pencil = "pencil"
    case exit = "rectangle.portrait.and.arrow.right"
    case checkmark = "checkmark"
    case chevronLeft = "chevron.left"
    case chevronRight = "chevron.right"
    case bookFill = "book.fill"
    
    var systemImage: Image {
        Image(systemName: self.rawValue)
    }
}
