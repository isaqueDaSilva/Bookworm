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
    @StateObject private var viewModel: AuthorSelectionViewModel
    
    // MARK: - View
    var body: some View {
        // START: LIST
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
                // When an author is tapped,
                //"authorSelected" must be set to the same value
                // contained in the author that was tapped.
                // and after that the View should be dismiss.
                
                authorSelected = author
                dismiss()
            }
            .contextMenu {
                Button {
                    // Opens the Editor for update an existing Author.
                    
                    viewModel.showingEditor(author)
                } label: {
                    Label("Edit", systemImage: Icons.pencil.rawValue)
                }
                
                Button(role: .destructive) {
                    // Delete the author selected
                    
                    viewModel.deleteAuthor(author)
                } label: {
                    Label("Delete", systemImage: Icons.trash.rawValue)
                }
            }
        }
        .navigationTitle("Choice an Author")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            // Performs a search for saved authors when the View appears.
            
            viewModel.fetchAuthors()
        }
        .toolbar {
            Button {
                // Opens the Editor for create a new Author.
                
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
            Button("OK") {
                // Save the changes will be occur.
                
                viewModel.saveChanges()
            }
        } message: {
            Text("Insert the author name in session bellow.")
        }
        // END: LIST

    }
    
    /// This View shows the entire collection of authors that the user has.
    /// - Parameters:
    ///   - authorSelected: An association with an Author value that determines whether there are any authors selected or not.
    ///   - storage: The type that contains the default container and viewContext types, of Core Data.
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
