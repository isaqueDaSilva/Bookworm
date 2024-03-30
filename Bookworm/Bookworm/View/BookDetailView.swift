//
//  BookDetailView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 05/03/24.
//

import SwiftUI

struct BookDetailView: View {
    // MARK: View Properties
    @Environment(\.dismiss) var dismiss
    @Environment(\.horizontalSizeClass) var sizeClass
    @StateObject private var viewModel: BookDetailViewModel
    
    // MARK: View
    var body: some View {
        List {
            Section {
                let layout = (sizeClass == .compact) ? AnyLayout(VStackLayout()) : AnyLayout(HStackLayout())
                
                layout {
                    Cover(
                        coverImage: viewModel.coverImage,
                        title: viewModel.title
                    )
                    
                    VStack(alignment: (sizeClass == .compact) ? .center : .leading) {
                        Description(
                            title: viewModel.title,
                            author: viewModel.author
                        )
                    }
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
                // START: SECTION 4
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
        .onChange(of: viewModel.book) { oldValue, newValue in
            if oldValue != newValue {
                viewModel.book = newValue
            }
        }
        .toolbar {
            Button("Edit") {
                viewModel.showingEditView = true
            }
        }
        .sheet(isPresented: $viewModel.showingEditView) {
            BookFormView(storage: viewModel.storage, book: viewModel.book)
        }
        .alert(viewModel.alertTitle, isPresented: $viewModel.showingAlert) {
            if viewModel.isDeletingAlert {
                Button("Cancel", role: .cancel) { }
                
                Button("OK", role: .destructive) {
                    viewModel.deleteBook()
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
    
    init(storage: Storage, book: Book) {
        _viewModel = StateObject(wrappedValue: BookDetailViewModel(storage: storage, book: book))
    }
}

#Preview {
    NavigationStack {
        BookDetailView(storage: .preview, book: Storage.dummyBook)
    }
}
