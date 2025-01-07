//
//  DeleteBookButton.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/2/25.
//


import SwiftUI

extension HomeView {
    struct DeleteBookButton: View {
        @Environment(ViewModel.self) private var viewModel
        
        let isTitleHidden: Bool
        let book: Book
        
        var body: some View {
            DeleteButton(
                isShownLabel: !isTitleHidden,
                target: isTitleHidden ? "" : "Book"
            ) {
                withAnimation(.spring.delay(0.65)) {
                    viewModel.deleteBook(book)
                }
            }
        }
    }
}

#Preview {
    let deleteButtonWithTitle = HomeView.DeleteBookButton(isTitleHidden: false, book: .init())
    
    let deleteButtonWithTitleHidden = HomeView.DeleteBookButton(isTitleHidden: true, book: .init())
    
    VStack {
        deleteButtonWithTitle
            .padding()
        deleteButtonWithTitleHidden
    }
    .environment(HomeView.ViewModel(storage: .preview))
}
