//
//  ListHomeView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/2/25.
//


import SwiftUI

extension HomeView {
    struct ListHomeView: View {
        @Environment(ViewModel.self) private var viewModel
        
        var body: some View {
            List(viewModel.booksFiltered) { book in
                NavigationLink(value: book) {
                    Cover(
                        coverImage: book.coverImage,
                        title: book.wrappedTitle,
                        size: .coverMiniature
                    )
                    .padding(.trailing, 5)
                    
                    VStack(alignment: .leading) {
                        Description(
                            title: book.wrappedTitle,
                            author: book.wrappedAuthorName
                        )
                    }
                }
                .swipeActions {
                    DeleteBookButton(isTitleHidden: true, book: book)
                        .environment(viewModel)
                }
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    HomeView.ListHomeView()
        .environment(HomeView.ViewModel(storage: .preview))
}
