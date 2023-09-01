//
//  BookDetailsView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import SwiftUI

struct BookDetailsView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = BookDetailsViewModel()
    let book: Books
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.wrappedGenre)
                    .resizable()
                    .scaledToFit()
                
                Text(book.wrappedGenre.uppercased())
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .offset(x: -5, y: -5)
            }
            
            VStack {
                Text(book.author?.wrappedName ?? "Unknown Author")
                    .font(.largeTitle)
                    .foregroundColor(.secondary)
                
                Text("In: \(viewModel.dateFormatter.string(from: book.wrappedReleaseDate))")
                    .font(.headline.bold())
                
                Text(book.wrappedReview)
                    .font(.headline.bold())
                    .padding()
                
                RatingStars(rating: .constant(Int(book.rating)))
            }
        }
        .navigationTitle(book.wrappedTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button{
                viewModel.deleteCurrentBookAlert = true
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
        .alert("Delete Book", isPresented: $viewModel.deleteCurrentBookAlert) {
            Button("Delete", role: .destructive) {
                viewModel.deleteCurrentBook(book)
                dismiss()
            }
            
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to delete this book?")
        }
    }
}
