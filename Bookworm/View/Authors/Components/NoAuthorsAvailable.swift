//
//  NoAuthorsAvailable.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/4/25.
//

import SwiftUI

extension AuthorsView {
    struct NoAuthorsAvailable: View {
        var body: some View {
            ContentUnavailableView(
                "No Authors Saved",
                systemImage: Icons.person.rawValue,
                description:
                    Text("Tap the + Button to create one.").bold()
            )
        }
    }
}

#Preview {
    AuthorsView.NoAuthorsAvailable()
}
