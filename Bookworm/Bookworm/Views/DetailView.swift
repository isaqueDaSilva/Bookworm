//
//  DetailView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 25/08/23.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = DetailViewModel()
    @StateObject var contentViewModel = ContentViewModel()
    let book: Book
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre ?? "Fantasy")
                    .font(.caption.bold())
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .offset(x: -5, y: -5)
            }
            
            Text(book.author?.uppercased() ?? "UNKNOWN")
                .font(.largeTitle.bold())
                .foregroundColor(.secondary)
            
            Text(book.review ?? "No Review")
                .padding()
            
            Rating(rating: .constant(Int(book.rating)))
                .font(.title)
        }
        .navigationTitle(book.title ?? "Unknown")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button(action: {
                viewModel.showingAlert = true
            }, label: {
                Label("Delete Book", systemImage: "trash")
            })
        }
        .alert("Delete Book", isPresented: $viewModel.showingAlert) {
            Button("Delete", role: .destructive) {
                contentViewModel.deleteCurrentBook(book)
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to delete this book?")
        }
    }
}
