//
//  BookDescription.swift
//  Bookworm
//
//  Created by Isaque da Silva on 21/01/24.
//

import SwiftUI

struct Description: View {
    let title: String
    let description: String
    let primaryFont: Font
    let secondaryFont: Font
    
    var body: some View {
        Group {
            Text(title)
                .font(primaryFont)
                .bold()
                .foregroundStyle(.primary)
            
            Text(description)
                .font(secondaryFont)
                .bold()
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    Description(title: "Title Test", description: "Author Test", primaryFont: .title2, secondaryFont: .subheadline)
}
