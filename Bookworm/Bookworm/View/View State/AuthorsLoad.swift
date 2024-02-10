//
//  AuthorsLoad.swift
//  Bookworm
//
//  Created by Isaque da Silva on 09/02/24.
//

import SwiftUI

extension AuthorView {
    @ViewBuilder
    func AuthorsLoad() -> some View {
        List {
            ForEach(viewModel.authorList) { author in
                HStack {
                    Text(author.authorName)
                        .onTapGesture {
                            viewModel.currentAuthor = author
                        }
                    Spacer()
                    Image(systemName: "square.and.pencil")
                        .onTapGesture {
                            viewModel.addOrEditAuthor(author: author)
                        }
                }
            }
        }
        .navigationTitle("Select a Author")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton {
                    dismiss()
                }
            }
            
            ToolbarItem {
                Button("Add") {
                    viewModel.addOrEditAuthor()
                }
            }
        }
        .alertWithTextField(
            text: $viewModel.authorName,
            isActive: $viewModel.addNewOrEditAuthor,
            title: "\(viewModel.isEditAuthor ? "Edit" : "Add New") Author",
            primaryButtonTitle: "OK",
            secondaryButtonTitle: "Cancel",
            message: "\(viewModel.isEditAuthor ? "Edit" : "Insert a new") Author in session below...",
            placeholder: "Author name",
            isDisabled: viewModel.isValid,
            secondaryRole: .cancel,
            primaryAction: viewModel.isEditAuthor ? viewModel.editAuthor : viewModel.createAuthor
        )
        .sheet(item: $viewModel.currentAuthor) { author in
            AddAndEditBookView(author: author, authenticator: viewModel.authenticationManager)
        }
    }
}
