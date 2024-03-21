//
//  AnnotationListView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 05/03/24.
//

import SwiftUI

struct AnnotationListView: View {
    // MARK: - View Properties
    @StateObject private var viewModel: AnnotationListViewModel
    
    // MARK: - View
    var body: some View {
        Group {
            if viewModel.annotations.isEmpty {
                ContentUnavailableView(
                    "No Annotation Saved",
                    systemImage: Icons.squareAndPencil.rawValue,
                    description:
                        Text("Tap the + Button to create one.").bold()
                )
            } else {
                AnnotationPopulaedView()
            }
        }
        .navigationTitle("Annotations")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            // When this View appears,
            // a search will be performed
            // looking for saved notes.
            
            viewModel.fetchAnnotations()
        }
        .toolbar {
            Button {
                // Displays the AnnotationFormView
                // for created a new Annotation.
                
                viewModel.showingFormView()
            } label: {
                Icons.plus.systemImage
            }
        }
        .sheet(
            isPresented: $viewModel.showingAddAnotationView,
            onDismiss: viewModel.fetchAnnotations
        ) {
            AnnotationFormView(
                storage: viewModel.storage,
                annotation: viewModel.annotationSelected,
                book: viewModel.book
            )
            .presentationDetents([
                (viewModel.annotationSelected != nil) ? .fraction(0.65) : .medium
            ])
        }
        // END: LIST
    }
    
    /// This View shows the entire collection of annotations that the book selected has.
    /// - Parameters:
    ///   - storage: An association with an Author value that determines whether there are any authors selected or not.
    ///   - book: The book that should be used to create, read, update and delete the annotations.
    init(storage: Storage, book: Book) {
        _viewModel = StateObject(
            wrappedValue: AnnotationListViewModel(storage: storage, book: book)
        )
    }
}

// MARK: - View Populated State

extension AnnotationListView {
    @ViewBuilder
    func AnnotationPopulaedView() -> some View {
        // START: LIST
        List(viewModel.annotations) { annotation in
            Button {
                // When an annotation is tapped,
                // the AnnotationFormView must be displayed
                // so that it can be edited.
                
                viewModel.showingFormView(annotation)
            } label: {
                VStack(alignment: .leading) {
                    Text(annotation.wrappedTitle)
                        .font(.title3)
                        .bold()
                    Text(annotation.wrappedCommentDescription)
                        .font(.headline)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
                .contextMenu {
                    Button("Delete Annotation", systemImage: Icons.trash.rawValue, role: .destructive) {
                        // Peforms the deletion of the annotation Selected.
                        
                        viewModel.deleteAnnotation(annotation)
                    }
                }
            }
            .buttonStyle(.plain)
        }
        // END: List
    }
}

#Preview {
    NavigationStack {
        AnnotationListView(storage: .preview, book: Storage.dummyBook)
    }
}
