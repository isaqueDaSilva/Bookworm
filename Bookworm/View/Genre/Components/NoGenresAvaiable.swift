//
//  NoGenresAvaiable.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/5/25.
//

import SwiftUI

extension GenresView {
    struct NoGenresAvaiable: View {
        var body: some View {
            ContentUnavailableView(
                "No Genres Saved",
                systemImage: Icons.magnifyingglass.rawValue,
                description:
                    Text("Tap the + Button to create one.").bold()
            )
        }
    }
}

#Preview {
    GenresView.NoGenresAvaiable()
}
