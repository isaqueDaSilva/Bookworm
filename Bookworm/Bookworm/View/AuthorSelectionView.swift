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
        List {
            ForEach(viewModel.authorList, id: \.wrappedName) { author in
                HStack {
                    Text(author.wrappedName)
                    Spacer()
                    if author == viewModel.authorSelected {
                        Image(systemName: "checkmark")
                            .foregroundStyle(.tint)
                            .font(.body.weight(.semibold))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture {
                    viewModel.authorSelected = author
                    action(author)
                    dismiss()
                }
                .contextMenu {
                    Button {
                        alertWithTextField(
                            title: "Update Author",
                            message: "",
                            text: author.wrappedName,
                            placeholder: "Insert the author name here",
                            primaryButtonTitle: "OK",
                            secondaryButtonTitle: "Cancel"
                        ) { authorName in
                            viewModel.updateAuthor(author, authorName)
                        }
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
        }
        .navigationTitle("Choice an Author")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                alertWithTextField(
                    title: "New Author",
                    message: "Create a new author to use them to register a new book.",
                    placeholder: "Insert the author name here",
                    primaryButtonTitle: "OK",
                    secondaryButtonTitle: "Cancel"
                ) { authorName in
                    viewModel.createAuthor(authorName)
                }
            } label: {
                Icons.plus.systemImage
            }
        }
        .alert(viewModel.errorTitle, isPresented: $viewModel.showingError) {
        } message: {
            Text(viewModel.errorMessage)
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
