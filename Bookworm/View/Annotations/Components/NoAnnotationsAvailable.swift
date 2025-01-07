//
//  NoAnnotationsAvailable.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/4/25.
//

import SwiftUI

extension AnnotationsView {
    struct NoAnnotationsAvailable: View {
        var body: some View {
            ContentUnavailableView(
                "No Annotation Saved",
                systemImage: Icons.squareAndPencil.rawValue,
                description:
                    Text("Tap the + Button to create one.").bold()
            )
        }
    }
}

#Preview {
    AnnotationsView.NoAnnotationsAvailable()
}
