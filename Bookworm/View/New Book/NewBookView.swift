//
//  NewBookView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/4/25.
//

import ErrorWrapper
import SwiftUI

struct NewBookView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = ViewModel()
    @State private var imageSetter = ImageSetter()
    
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
            .navigationTitle("New Book")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButton {
                        dismiss()
                    }
                }
                
                ToolbarItem {
                    SaveButton {
                        viewModel.createBook(
                            coverImageData: imageSetter.coverImageData
                        )
                        dismiss()
                    }
                    .disabled(viewModel.isDisabled)
                }
            }
        }
    }
}

#Preview {
    NewBookView()
}
