//
//  GridHomeView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/2/25.
//


import SwiftUI

extension HomeView {
    struct GridHomeView: View {
        @Environment(ViewModel.self) private var viewModel
        
        private let colums = [GridItem(.adaptive(minimum: 150), spacing: 10, alignment: .top)]
        
        var body: some View {
            ScrollView {
                LazyVGrid(columns: colums, spacing: 20) {
                    ForEach(viewModel.booksFiltered) { book in
                        NavigationLink(value: book) {
                            VStack(alignment: .leading) {
                                Cover(
                                    coverImage: book.coverImage,
                                    title: book.wrappedTitle,
                                    size: .coverFullSize
                                )
                                .shadow(color: .black.opacity(0.15), radius: 5, x: 5, y: 5)
                                .shadow(color: .black.opacity(0.15), radius: 5, x: -5, y: -5)
                                .contextMenu {
                                    DeleteBookButton(isTitleHidden: false, book: book)
                                        .environment(viewModel)
                                }
                                
                                Description(
                                    title: book.wrappedTitle,
                                    author: book.wrappedAuthorName
                                )
                                .disabled(true)
                            }
                        }
                        .navigationStackButtonStyle()
                    }
                }
                .padding(.top)
            }
            .scrollBounceBehavior(.basedOnSize)
        }
    }
}

#Preview {
    HomeView.GridHomeView()
        .environment(HomeView.ViewModel(storage: .preview))
}
