//
//  AnnotationListView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 05/03/24.
//

import SwiftUI

struct AnnotationListView: View {
    // MARK: - View Properties
    @StateObject var viewModel: AnnotationListViewModel
    
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

#Preview {
    NavigationStack {
        AnnotationListView(storage: .preview, book: Storage.dummyBook)
    }
}
