//
//  DeleteBook.swift
//  Bookworm
//
//  Created by Isaque da Silva on 30/03/24.
//

import SwiftUI

extension HomeView {
    @ViewBuilder
    func DeleteBook(_ book: Book, titleHidden: Bool) -> some View {
        Button(role: .destructive) {
            withAnimation(.spring.delay(0.65)) {
                viewModel.deleteBook(book)
            }
        } label: {
            Label(
                titleHidden ? "" : "Delete Book",
                systemImage: Icons.trash.rawValue
            )
                
        }
    }
}

#Preview {
    let homeView = HomeView(storage: Storage.preview)
    let deleteButtonWithTitle = homeView.DeleteBook(Book(), titleHidden: false)
    
    let deleteButtonWithTitleHidden = homeView.DeleteBook(Book(), titleHidden: true)
    
    return VStack {
        deleteButtonWithTitle
            .padding()
        deleteButtonWithTitleHidden
    }
}
