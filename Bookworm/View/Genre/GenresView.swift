//
//  GenresView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/5/25.
//

import ErrorWrapper
import SwiftUI

struct GenresView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var selectedGenre: Genre?
    @State private var viewModel: ViewModel
    
    var body: some View {
        Group {
            if viewModel.genres.isEmpty {
                NoGenresAvaiable()
            } else {
                GenreListPopulated(
                    selectedGenre: $selectedGenre
                ) {
                    dismiss()
                }
                .environment(viewModel)
            }
        }
        .navigationTitle("Genres")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            AddButton {
                viewModel.showAddNewGenre()
            }
        }
        .sheet(isPresented: $viewModel.showingAddNewGenre) {
            NewGenreView()
                .presentationDetents(
                    [.fraction(0.3)]
                )
        }
        .errorAlert(error: $viewModel.error) { }
    }
    
    init(storage: Storage = .shared, selectedGenre: Binding<Genre?>) {
        self._selectedGenre = selectedGenre
        self._viewModel = State(initialValue: .init(storage: storage))
    }
}

#Preview {
    NavigationStack {
        GenresView(storage: .preview, selectedGenre: .constant(nil))
    }
}
