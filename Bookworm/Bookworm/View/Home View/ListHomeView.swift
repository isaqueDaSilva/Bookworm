//
//  ListHomeView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 30/03/24.
//

import SwiftUI

extension HomeView {
    @ViewBuilder
    func ListHomeView() -> some View {
        List(viewModel.booksFiltered) { book in
            NavigationLink(value: book) {
                Cover(
                    coverImage: book.coverImage,
                    title: book.wrappedTitle,
                    width: 75,
                    height: 100
                )
                VStack(alignment: .leading) {
                   Description(
                    title: book.wrappedTitle,
                    author: book.wrappedAuthorName
                   )
                }
            }
            .swipeActions {
                DeleteBook(book, titleHidden: true)
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    let homeView = HomeView(storage: Storage.preview)
    homeView.displayingMode = .list
    
    return homeView
}
