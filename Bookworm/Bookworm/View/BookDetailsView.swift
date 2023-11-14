//
//  BookDetailsView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import SwiftUI

struct BookDetailsView: View {
    @StateObject var viewModel: BookDetailsViewModel
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(viewModel.bookGenre)
                    .resizable()
                    .scaledToFit()
                
                Text(viewModel.bookGenre.uppercased())
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .offset(x: -5, y: -5)
            }
            
            VStack {
                Text(viewModel.bookAuthor)
                    .font(.largeTitle)
                    .foregroundColor(.secondary)
                
                Text("In: \(viewModel.bookReleaseDate)")
                    .font(.headline.bold())
                
                Text(viewModel.bookReview)
                    .font(.headline.bold())
                    .padding()
                
                RatingStars(rating: .constant(viewModel.bookRating))
            }
        }
        .navigationTitle(viewModel.bookTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                viewModel.displayAlert()
            } label: {
                Image(systemName: "trash")
            }
        }
        .alert("Delete this Book", isPresented: $viewModel.deleteCurrentBookAlert) {
            Button("Delete", role: .destructive, action: viewModel.delete)
            Button("Cancel", role: .cancel, action: {})
        } message: {
            Text("Are you sure you want to delete this book?")
        }

    }
    
    init(manager: BooksMananger, book: Books, onChange: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: BookDetailsViewModel(manager: manager, book: book, onChange: onChange))
    }
}
