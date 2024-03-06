//
//  BookDetailView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 05/03/24.
//

import SwiftUI

struct BookDetailView: View {
    @StateObject private var viewModel: BookDetailViewModel
    var body: some View {
        List {
            Section {
                Cover(
                    title: viewModel.title,
                    author: viewModel.author
                )
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .listRowBackground(Color.listLightGray)
            
            Section("More Information") {
                LabeledContent("Title:") {
                    Text(viewModel.title)
                }
                
                LabeledContent("Author:") {
                    Text(viewModel.author)
                }
                
                LabeledContent("Release Date:") {
                    Text(viewModel.releaseDate)
                }
                
                LabeledContent("Genre:") {
                    Text(viewModel.genre)
                }
            }
            
            Section("Reading Information") {
                LabeledContent("Stating of Reading:") {
                    Text(viewModel.startOfReading)
                }
                if viewModel.isFinished {
                    LabeledContent("End of Reading:") {
                        Text(viewModel.endOfReading)
                    }
                }
            }
            
            if viewModel.isFinished {
                Section("Review") {
                    LabeledContent("Rating:") {
                        RatingStars(rating: .constant(viewModel.rating))
                    }
                    
                    LabeledContent("Review:") {
                        Text(viewModel.review)
                    }
                }
            }
            
            Section {
                Button {
                    viewModel.showingAnnotationView = true
                } label: {
                    HStack {
                        LabeledContent("Annotations") {
                            Text(viewModel.annotationsCount, format: .number)
                            Icons.chevronRight.systemImage
                        }
                    }
                }
                .buttonStyle(.plain)
            }
            
            Section {
                Button(role: .destructive) {
                    viewModel.displayDeleteAlert()
                } label: {
                    Label("Delete Book", systemImage: Icons.trash.rawValue)
                        .foregroundStyle(.red)
                }
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Edit") {
                viewModel.showingEditView = true
            }
        }
        .sheet(isPresented: $viewModel.showingEditView) {
            BookFormView(storage: viewModel.storage, book: viewModel.book) {
                viewModel.fetchChanges()
            }
        }
        .alert(viewModel.alertTitle, isPresented: $viewModel.showingAlert) {
            if viewModel.isDeletingAlert {
                Button("Cancel", role: .cancel) { }
                
                Button("OK", role: .destructive) {
                    viewModel.deleteBook()
                }
            }
        } message: {
            Text(viewModel.alertMessage)
        }
        .navigationDestination(isPresented: $viewModel.showingAnnotationView) {
            AnnotationListView(storage: viewModel.storage, book: viewModel.book)
        }
    }
    
    init(storage: Storage, book: Book) {
        _viewModel = StateObject(wrappedValue: BookDetailViewModel(storage: storage, book: book))
    }
}

#Preview {
    NavigationStack {
        BookDetailView(storage: .preview, book: dummyBook)
    }
}
