//
//  EditBookView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/6/25.
//

import SwiftUI

struct EditBookView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: ViewModel
    @State private var imageSetter: ImageSetter
    
    var body: some View {
        NavigationStack {
            BookEdit(
                coverImage: $imageSetter.coverImage,
                pickerItemSelect: $imageSetter.pickerItemSelect,
                title: $viewModel.title,
                selectedAuthor: $viewModel.author,
                releaseDate: $viewModel.releaseDate,
                selectedGenre: $viewModel.genre,
                startOfReading: $viewModel.startOfReading,
                endOfReading: $viewModel.endOfReading,
                isFinished: $viewModel.isFinished,
                rating: $viewModel.rating,
                review: $viewModel.review
            )
            .navigationTitle("Edit Book")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButton {
                        dismiss()
                    }
                }
                
                ToolbarItem {
                    SaveButton {
                        viewModel.editBook(
                            coverImageData: imageSetter.coverImageData
                        )
                        dismiss()
                    }
                    .disabled(viewModel.isDisabled)
                }
            }
        }
    }
    
    init(book: Book) {
        self.viewModel = .init(book: book)
        self.imageSetter = .init(
            coverImage: book.coverImage,
            coverImageData: book.cover
        )
    }
}

#Preview {
    let preview = PreviewBook()
    
    EditBookView(book: preview.books[0])
}
