//
//  AuthorSelectionView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 02/03/24.
//

import SwiftUI

struct AuthorSelectionView: View {
    @Binding var authorSelected: Author?
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: AuthorSelectionViewModel
    
    var body: some View {
        List(viewModel.authorList) { author in
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
            .onTapGesture {
                authorSelected = author
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
        .onAppear {
            viewModel.fetchAuthors()
        }
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
