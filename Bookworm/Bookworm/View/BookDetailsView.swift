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
        List {
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
            
            Section("About Book") {
                TextDetails(title: "Author", description: viewModel.bookAuthor, displayInfo: true) { text in
                    viewModel.displaySafariSearchFor(text)
                }
                
                TextDetails(title: "Release in:", description: viewModel.bookReleaseDate, displayInfo: false)
                
                TextDetails(title: "Genre:", description: viewModel.bookGenre, displayInfo: true) { text in
                    viewModel.displaySafariSearchFor(text)
                }
                
            }
            
            Section("Review") {
                Text(viewModel.bookReview)
                    .font(.headline)
            }
            
            HStack {
                Spacer()
                
                VStack {
                    RatingStars(rating: .constant(viewModel.bookRating))
                        .font(.system(size: 25))
                        .padding(5)
                    Text("\(viewModel.bookRating)/5")
                        .bold()
                        .foregroundStyle(.gray)
                }
                Spacer()
            }
            .listRowBackground(Color(CGColor(red: 240, green: 240, blue: 246, alpha: 0)))
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
            Button("Delete", role: .destructive) {
                Task {
                    await viewModel.delete()
                }
            }
            Button("Cancel", role: .cancel, action: {})
        } message: {
            Text("Are you sure you want to delete this book?")
        }
        .sheet(isPresented: $viewModel.showingSafafiView) {
            SafariServiceView(seachText: viewModel.selectedText)
        }
    }
    
    init(manager: DataServiceProtocol, book: Book, onChange: @escaping () async -> Void) {
        _viewModel = StateObject(wrappedValue: BookDetailsViewModel(manager: manager, book: book, onChange: onChange))
    }
}
