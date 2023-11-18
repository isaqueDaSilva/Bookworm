//
//  EmojiRating.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import SwiftUI

struct EmojiRating: View {
    let rating: Int
    
    var body: some View {
        switch rating {
        case 1:
            Text("😖")
        case 2:
            Text("🙁")
        case 3:
            Text("😐")
        case 4:
            Text("☺️")
        default:
            Text("🤩")
        }
    }
}
