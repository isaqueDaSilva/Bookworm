//
//  AuthorsView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/4/25.
//

import ErrorWrapper
import SwiftUI

struct AuthorsView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var authorSelected: Author?
    @State private var viewModel: ViewModel
    
    var body: some View {
        Group {
            if viewModel.authors.isEmpty {
                NoAuthorsAvailable()
            } else {
                AuthorListPopulated(
                    authorSelected: $authorSelected
                ) {
                    dismiss()
                }
                .environment(viewModel)
            }
        }
        .navigationTitle("Authors")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            AddButton {
                viewModel.showAddNewAuthor()
            }
        }
        .sheet(isPresented: $viewModel.showingAddNewAuthor) {
            NewAuthorView()
                .presentationDetents(
                    [.fraction(0.3)]
                )
        }
        .errorAlert(error: $viewModel.error) { }
    }
    
    init(
        author: Binding<Author?>,
        storage: Storage = .shared
    ) {
        self._authorSelected = author
        self._viewModel = State(initialValue: .init(storage: storage))

    }
}

#Preview {
    NavigationStack {
        AuthorsView(author: .constant(nil), storage: .preview)
    }
}
