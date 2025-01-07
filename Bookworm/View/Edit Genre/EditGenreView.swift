//
//  EditGenreView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/5/25.
//

import ErrorWrapper
import SwiftUI

struct EditGenreView: View {
    @Environment(\.dismiss) private var dismiss
    let genre: Genre
    
    @State private var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            SingleFormEdit(name: $viewModel.genreName)
                .navigationTitle("Edit Genre")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        SaveButton {
                            viewModel.updateGenre(genre)
                            dismiss()
                        }
                        .disabled(!viewModel.isValidCreationValid)
                    }
                    
                    ToolbarItem(placement: .cancellationAction) {
                        BackButton {
                            dismiss()
                        }
                    }
                }
                .errorAlert(error: $viewModel.error) { }
        }
    }
    
    init(genre: Genre) {
        self.genre = genre
        self._viewModel = .init(initialValue: .init(genreName: genre.wrappedName))
    }
}

#Preview {
    let preview = PreviewBook()
    
    EditGenreView(genre: preview.books[0].genre!)
}
