//
//  AuthorSelectionView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 02/03/24.
//

import SwiftUI

struct AuthorSelectionView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: AuthorSelectionViewModel
    
    var action: (Author) -> Void
    
    var body: some View {
        List(viewModel.authorList) { author in
            HStack {
                Text(author.wrappedName)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                if author == viewModel.authorSelected {
                    Image(systemName: "checkmark")
                        .foregroundStyle(.tint)
                        .font(.body.weight(.semibold))
                }
            }
            .onTapGesture {
                viewModel.authorSelected = author
                action(author)
                dismiss()
            }
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
        .navigationTitle("Choice an Author")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                viewModel.showingEditor()
            } label: {
                Icons.plus.systemImage
            }
        }
        .alert(viewModel.errorTitle, isPresented: $viewModel.showingError) {
        } message: {
            Text(viewModel.errorMessage)
        }
        .alert(viewModel.editorTitle, isPresented: $viewModel.showingEditor) {
            TextField("Author name", text: $viewModel.authorName)
            
            Button("Cancel", role: .cancel) { }
            Button("OK") { viewModel.saveChanges() }
        } message: {
            Text("Insert the author name in session bellow.")
        }

    }
    
    init(authorSelected: Author? = nil, storage: Storage, action: @escaping (Author) -> Void) {
        _viewModel = StateObject(wrappedValue: AuthorSelectionViewModel(storage: storage, author: authorSelected))
        self.action = action
    }
}

#Preview {
    NavigationStack {
        AuthorSelectionView(storage: .preview) { _ in }
    }
}
