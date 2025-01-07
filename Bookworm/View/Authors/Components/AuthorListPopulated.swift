//
//  AuthorListPopulated.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/4/25.
//

import SwiftUI

extension AuthorsView {
    struct AuthorListPopulated: View {
        @Environment(ViewModel.self) private var viewModel
        
        @Binding var authorSelected: Author?
        var dismiss: () -> Void
        
        var body: some View {
            @Bindable var viewModel = viewModel
            
            List(viewModel.authors) { author in
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
                    EditButton {
                        viewModel.showEditAuthor()
                    }
                    
                    DeleteButton(
                        isShownLabel: true,
                        target: "Author"
                    ) {
                        viewModel.deleteAuthor(author)
                    }
                }
                .sheet(isPresented: $viewModel.showingEditAuthor) {
                    EditAuthorView(author: author)
                        .presentationDetents(
                            [.fraction(0.3)]
                        )
                }
            }
        }
    }
}

#Preview {
    AuthorsView.AuthorListPopulated(authorSelected: .constant(nil)) { }
        .environment(AuthorsView.ViewModel(storage: .preview))
}
