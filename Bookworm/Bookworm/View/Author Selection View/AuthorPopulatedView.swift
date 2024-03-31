//
//  AuthorPopulatedView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 30/03/24.
//

import SwiftUI

extension AuthorSelectionView {
    @ViewBuilder
    func AuthorPopulatedView() -> some View {
        List(viewModel.authorList) { author in
            Button {
                authorSelected = author
                dismiss()
            } label: {
                HStack {
                    Text(author.wrappedName)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    if author == authorSelected {
                        Image(systemName: "checkmark")
                            .foregroundStyle(.tint)
                            .font(.body.weight(.semibold))
                    }
                }
                .frame(maxWidth: .infinity)
                .contextMenu {
                    Button {
                        viewModel.showingEditor(author)
                    } label: {
                        Label("Edit", systemImage: Icons.pencil.rawValue)
                    }
                    
                    Button(role: .destructive) {
                        viewModel.deleteAuthor(author)
                    } label: {
                        Label("Delete", systemImage: Icons.trash.rawValue)
                    }
                }
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    AuthorSelectionView(authorSelected: .constant(nil), storage: .preview)
}
