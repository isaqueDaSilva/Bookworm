//
//  EditAuthorView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/5/25.
//

import ErrorWrapper
import SwiftUI

struct EditAuthorView: View {
    @Environment(\.dismiss) private var dismiss
    let author: Author
    
    @State private var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            SingleFormEdit(name: $viewModel.authorName)
                .navigationTitle("Edit Author")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        SaveButton {
                            viewModel.updateAuthor(author)
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
    
    init(author: Author) {
        self._viewModel = State(
            initialValue: .init(
                authorName: author.wrappedName
            )
        )
        
        self.author = author
    }
}

#Preview {
    let preview = PreviewBook()
    
    EditAuthorView(author: preview.books[0].author!)
}
