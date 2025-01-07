//
//  BookDetailView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/2/25.
//

import ErrorWrapper
import SwiftUI

struct BookDetailView: View {
    @Environment(\.horizontalSizeClass) private var sizeClass
    @Environment(\.dismiss) private var dismiss

    let book: Book
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                cover
                
                Divider()
                    .padding(.bottom)
                
                moreInformation
                
                readingInformation
                
                if book.isFinished {
                    review
                }
                
                annotationViewButton
            }
            .navigationTitle(book.wrappedTitle)
            .navigationBarTitleDisplayMode(.inline)
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    HStack {
                        DeleteButton {
                            viewModel.showDeletionAlert()
                        }
                        
                        EditButton {
                            viewModel.showEditBookView()
                        }
                    }
                }
            }
            .alert(
                "Delete Book",
                isPresented: $viewModel.showingAlert
            ) {
                if viewModel.isDeletingAlert {
                    Button("Cancel", role: .cancel) { }
                    
                    Button("OK", role: .destructive) {
                        viewModel.deleteBook(book)
                        dismiss()
                    }
                }
            } message: {
                Text("Are you sure you want to delete this book?")
            }
            .errorAlert(error: $viewModel.error) { }
            .sheet(isPresented: $viewModel.showingEditBookView) {
                EditBookView(book: book)
            }
        }
    }
}

// MARK: - Cover -
extension BookDetailView {
    @ViewBuilder
    private var cover: some View {
        let layout = (sizeClass == .compact) ? AnyLayout(VStackLayout()) : AnyLayout(HStackLayout())
        
        layout {
            Cover(
                coverImage: book.coverImage,
                title: book.wrappedTitle,
                size: .coverFullSize
            )
            
            VStack(alignment: (sizeClass == .compact) ? .center : .leading) {
                Description(
                    title: book.wrappedTitle,
                    author: book.wrappedAuthorName
                )
            }
        }
    }
}

// MARK: - More Information -
extension BookDetailView {
    @ViewBuilder
    private var moreInformation: some View {
        VStack {
            HeaderText(header: "More Information:")
            
            
            LabeledContent {
                Text(book.wrappedReleaseDate.dateString())
            } label: {
                Text("Release Date:")
                    .font(.headline)
            }
            
            LabeledContent {
                Text(book.wrappedGenre)
            } label: {
                Text("Genre:")
                    .font(.headline)
            }
        }
        .padding(.bottom)
    }
}

// MARK: - Reading Information -
extension BookDetailView {
    @ViewBuilder
    private var readingInformation: some View {
        VStack {
            HeaderText(header: "Reading Information:")
            
            LabeledContent {
                Text(book.wrappedStartOfReading.dateString())
            } label: {
                Text("Stating of Reading:")
                    .font(.headline)
            }
            
            if book.isFinished {
                LabeledContent {
                    Text(book.wrappedEndOfReading.dateString())
                } label: {
                    Text("End of Reading:")
                        .font(.headline)
                }
            }
        }
        .padding(.bottom)
    }
}

// MARK: - Review -
extension BookDetailView {
    @ViewBuilder
    private var review: some View {
        VStack {
            HeaderText(header: "Review:")
            
            Text(book.wrappedReview)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 5)
            
            RatingStars(rating: .constant(Int(book.rating)))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.bottom)
    }
}

// MARK: - Annotations Button-
extension BookDetailView {
    @ViewBuilder
    private var annotationViewButton: some View {
        NavigationLink {
            AnnotationsView(book: book)
        } label: {
            LabeledContent {
                Text(book.wrappedAnnotations.count, format: .number)
                Icons.chevronRight.systemImage
            } label: {
                Text("Annotations")
                    .font(.headline)
            }
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#if DEBUG
#Preview {
    let preview = PreviewBook()
    
    NavigationStack {
        BookDetailView(
            book: preview.books[0]
        )
    }
}
#endif
