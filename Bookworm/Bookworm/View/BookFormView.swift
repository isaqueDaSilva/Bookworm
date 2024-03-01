//
//  CreateNewBookView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 28/02/24.
//

import SwiftUI

struct BookFormView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var storage: Storage
    @StateObject private var viewModel = CreateBookViewModel()
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                Form {
                    Section {
                        Cover(
                            title: viewModel.title.isEmpty ? "No Title" : viewModel.title,
                            author: viewModel.authorName
                        )
                    }
                    .frame(width: geo.size.width)
                    .listRowBackground(Color.listLightGray)
                    
                    Section("More Information") {
                        LabeledContent("Title:") {
                            TextField("Insert the title here...", text: $viewModel.title)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        NavigationLink(value: storage.authors) {
                            LabeledContent("Author:") {
                                Text(
                                    (viewModel.author != nil) ?
                                    viewModel.authorName : "Select an Author"
                                )
                            }
                        }
                        
                        DatePicker(
                            "Release Date:",
                            selection: $viewModel.releaseDate,
                            in: ...Date.now,
                            displayedComponents: .date
                        )
                        
                        Picker("Genre:", selection: $viewModel.genre) {
                            ForEach(Genre.allCases, id: \.id) {
                                Text($0.rawValue)
                            }
                        }
                    }
                    
                    Section("Review") {
                        TextField("Insert your review here...", text: $viewModel.review, axis: .vertical)
                    }
                    
                    Section {
                        VStack {
                            RatingStars(rating: $viewModel.rating)
                                .padding(.bottom, 5)
                            Text("\(viewModel.rating)/5")
                                .foregroundStyle(.secondary)
                                .bold()
                        }
                    }
                    .frame(width: geo.size.width)
                    .listRowBackground(Color.listLightGray)
                }
                .navigationTitle("Add new Book")
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(for: [Author].self) { authors in
                    AuthorsView(authorSelected: $viewModel.author)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            HStack {
                                Icons.chevronLeft.systemImage
                                Text("Back")
                            }
                        }

                    }
                    
                    ToolbarItem {
                        Button {
                            viewModel.addBook { book in
                                try storage.createBook(book)
                                dismiss()
                            }
                        } label: {
                            if viewModel.isLoadingState {
                                ProgressView()
                            } else {
                                Text("Save")
                            }
                        }
                    }
                }
                .alert(viewModel.errorTile, isPresented: $viewModel.showingError) {
                } message: {
                    Text(viewModel.errorMessage)
                }
                .environmentObject(storage)
            }
        }
    }
}

#Preview {
    CreateNewBookView()
        .environmentObject(Storage(isStoredInMemoryOnly: true))
}

extension Color {
    static var listLightGray = Color(CGColor(red: 246, green: 240, blue: 240, alpha: 0))
}
