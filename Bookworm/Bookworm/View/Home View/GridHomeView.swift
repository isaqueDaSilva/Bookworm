//
//  GridHomeView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 30/03/24.
//

import SwiftUI

extension HomeView {
    @ViewBuilder
    func GridHomeView() -> some View {
        ScrollView {
            LazyVGrid(columns: colums, spacing: 20) {
                ForEach(viewModel.booksFiltered) { book in
                    NavigationLink(value: book) {
                        VStack(alignment: .leading) {
                            Cover(
                                coverImage: book.coverImage,
                                title: book.wrappedTitle
                            )
                            .shadow(color: .black.opacity(0.15), radius: 5, x: 5, y: 5)
                            .shadow(color: .black.opacity(0.15), radius: 5, x: -5, y: -5)
                            .contextMenu {
                                DeleteBook(book, titleHidden: false)
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

#Preview {
    let homeView = HomeView(storage: Storage.preview)
    homeView.displayingMode = .icons
    
    return homeView
}
