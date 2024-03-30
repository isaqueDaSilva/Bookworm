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
        .toolbar {
            Button {
                viewModel.showingFormView()
            } label: {
                Icons.plusCircle.systemImage
            }
        }
        .sheet(
            isPresented: $viewModel.showingAddAnotationView
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
    }
    
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
        List(viewModel.annotations) { annotation in
            Button {
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
                        
                        viewModel.deleteAnnotation(annotation)
                    }
                }
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    NavigationStack {
        AnnotationListView(storage: .preview, book: Storage.dummyBook)
    }
}
