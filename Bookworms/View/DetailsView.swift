//
//  DetailsView.swift
//  Bookworms
//
//  Created by Isaque da Silva on 26/08/23.
//

import SwiftUI

struct DetailsView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var bookwormViewModel: BookwormViewModel
    @StateObject var viewModel = DetailViewModel()
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
                Text(book.wrappedAuthor)
                    .font(.largeTitle)
                    .foregroundColor(.secondary)
                
                Text("In: \(viewModel.dateFormatter.string(from: book.wrappedReleaseDate))")
                    .font(.headline.bold())
            }
            
            Text(book.wrappedReview)
                .padding()
            
            Rating(rating: .constant(Int(book.rating)))
                .font(.title)
            
        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                viewModel.deleteCurrentBookAlert = true
            } label: {
                Label("Delete", systemImage: "trash")
            }

        }
        .alert("Delete Book", isPresented: $viewModel.deleteCurrentBookAlert) {
            Button("Delete", role: .destructive) {
                bookwormViewModel.deleteCurrentBook(book)
                dismiss()
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to delete this book?")
        }
    }
}
