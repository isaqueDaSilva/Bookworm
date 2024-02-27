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
    
    var systemImage: Image {
        Image(systemName: self.rawValue)
    }
}
