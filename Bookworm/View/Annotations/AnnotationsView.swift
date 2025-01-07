//
//  AnnotationsView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/4/25.
//

import ErrorWrapper
import SwiftUI

struct AnnotationsView: View {
    @State private var viewModel: ViewModel
    @State private var selectedAnnotation: Annotation?
    
    private let book: Book
    
    var body: some View {
        Group {
            if viewModel.annotations.isEmpty {
                NoAnnotationsAvailable()
            } else {
                AnnotationsListPopulated(annotation: $selectedAnnotation)
                    .environment(viewModel)
            }
        }
        .navigationTitle("Annotations")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            AddButton {
                viewModel.showNewAnnotationView()
            }
        }
        .sheet(
            isPresented: $viewModel.showingNewAnotationView
        ) {
            NewAnnotationView(book: book)
        }
        .sheet(item: $selectedAnnotation) {
            selectedAnnotation = nil
        } content: { annotation in
            EditAnnotationView(annotation: annotation)
        }
        .errorAlert(error: $viewModel.error) { }
    }
    
    init(
        storage: Storage = .shared,
        book: Book
    ) {
        _viewModel = .init(
            initialValue: .init(
                storage: storage,
                bookTitle: book.wrappedTitle,
                annotations: book.wrappedAnnotations
            )
        )
        
        self.book = book
    }
}

#Preview {
    let preview = PreviewBook()
    
    NavigationStack {
        AnnotationsView(
            storage: .preview,
            book: preview.books[0]
        )
    }
}
