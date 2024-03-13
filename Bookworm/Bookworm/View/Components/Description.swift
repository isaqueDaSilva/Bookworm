//
//  Description.swift
//  Bookworm
//
//  Created by Isaque da Silva on 07/03/24.
//

import SwiftUI

/// Displays the title and reader's name below the cover.
struct Description: View {
    let title: String
    let author: String
    
    var body: some View {
        Group {
            Text(title)
                .font(.title3)
                .bold()
            
            Text(author)
                .font(.headline)
                .bold()
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    Description(title: "Dummy", author: "Dummy Author")
}
