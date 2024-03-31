//
//  AuthorSelectionView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 02/03/24.
//

import SwiftUI

struct AuthorSelectionView: View {
    // MARK: - View Properties
    @Binding var authorSelected: Author?
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: AuthorSelectionViewModel
    
    // MARK: - View
    var body: some View {
        Group {
            if viewModel.authorList.isEmpty {
                ContentUnavailableView(
                    "No Authors Saved",
                    systemImage: Icons.person.rawValue,
                    description:
                        Text("Tap the + Button to create one.").bold()
                )
            } else {
                AuthorPopulatedView()
            }
        }
        .navigationTitle("Choice an Author")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                viewModel.showingEditor()
            } label: {
                Icons.plusCircle.systemImage
            }
        }
        .alert(viewModel.errorTitle, isPresented: $viewModel.showingError) {
        } message: {
            Text(viewModel.errorMessage)
        }
        .alert(viewModel.editorTitle, isPresented: $viewModel.showingEditor) {
            TextField("Author name", text: $viewModel.authorName)
            
            Button("Cancel", role: .cancel) { }
            Button("OK") {
                viewModel.saveChanges()
            }
        } message: {
            Text("Insert the author name in session bellow.")
        }
    }
    
    init(authorSelected: Binding<Author?>, storage: Storage) {
        _viewModel = StateObject(wrappedValue: AuthorSelectionViewModel(storage: storage))
        _authorSelected = authorSelected
    }
}

#Preview {
    NavigationStack {
        AuthorSelectionView(authorSelected: .constant(nil), storage: .preview)
    }
}
