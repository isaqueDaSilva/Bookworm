//
//  BookDetailView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 05/03/24.
//

import SwiftUI

struct BookDetailView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: BookDetailViewModel
    
    var action: () -> Void
    
    var body: some View {
        List {
            Section {
                VStack {
                    Cover(
                        coverImage: viewModel.coverImage,
                        title: viewModel.title
                    )
                    
                    Description(
                        title: viewModel.title,
                        author: viewModel.author
                    )
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .listRowBackground(Color.listLightGray)
            
            Section("More Information") {
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
                    action()
                    dismiss()
                }
            }
        } message: {
            Text(viewModel.alertMessage)
        }
        .navigationDestination(isPresented: $viewModel.showingAnnotationView) {
            AnnotationListView(storage: viewModel.storage, book: viewModel.book)
        }
    }
    
    init(storage: Storage, book: Book, _ action: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: BookDetailViewModel(storage: storage, book: book))
        self.action = action
    }
}

#Preview {
    NavigationStack {
        BookDetailView(storage: .preview, book: dummyBook) { }
    }
}
