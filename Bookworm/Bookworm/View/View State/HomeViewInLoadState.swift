//
//  HomeViewInLoadState.swift
//  Bookworm
//
//  Created by Isaque da Silva on 07/02/24.
//

import SwiftUI

extension BooksHomeView {
    @ViewBuilder
    func HomeViewLoadState() -> some View {
        ScrollView {
            LazyVGrid(columns: columLayout) {
                ForEach(viewModel.books) { book in
                    NavigationLink(value: book) {
                        VStack(alignment: .center) {
                            //BookCover(width: 135, height: 180, customText: $viewModel.customTextForCover(book))
                            
                            Description(title: book.title, description: "", primaryFont: .title2, secondaryFont: .subheadline)
                                .foregroundStyle(colorScheme == .dark ? .white : .black)
                        }
                        .padding(.top)
                    }
                }
            }
        }
        .navigationTitle("Bookworm")
        .toolbar {
            ToolbarItem {
                AddButton(
                    title: "Add new Book",
                    systemImage: "plus.circle"
                ) {
                    viewModel.addNewBook = true
                }
            }
        }
        .navigationDestination(for: Book.self) { book in
            //BookDetailsView(authenticator: viewModel.authenticationManager, book: book)
        }
        .sheet(isPresented: $viewModel.addNewBook) {
            AuthorView(authenticator: viewModel.authenticationManager)
        }
    }
}
