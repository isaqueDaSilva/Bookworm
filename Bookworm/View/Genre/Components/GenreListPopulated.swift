//
//  GenreListPopulated.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/5/25.
//

import SwiftUI

extension GenresView {
    struct GenreListPopulated: View {
        @Environment(ViewModel.self) private var viewModel
        
        @Binding var selectedGenre: Genre?
        var dismiss: () -> Void
        
        var body: some View {
            @Bindable var viewModel = viewModel
            
            List(viewModel.genres) { genre in
                HStack {
                    Text(genre.wrappedName)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    if genre == selectedGenre {
                        Image(systemName: "checkmark")
                            .foregroundStyle(.tint)
                            .font(.body.weight(.semibold))
                    }
                }
                .onTapGesture {
                    selectedGenre = genre
                    dismiss()
                }
                .contextMenu {
                    EditButton {
                        viewModel.showEditGenre()
                    }
                    
                    DeleteButton(
                        isShownLabel: true,
                        target: "Author"
                    ) {
                        viewModel.deleteGenre(genre)
                    }
                }
                .sheet(isPresented: $viewModel.showingEditGenre) {
                    EditGenreView(genre: genre)
                        .presentationDetents(
                            [.fraction(0.3)]
                        )
                }
            }
        }
    }
}

#Preview {
    GenresView.GenreListPopulated(selectedGenre: .constant(nil)) {
    }
    .environment(GenresView.ViewModel(storage: .preview))
}
