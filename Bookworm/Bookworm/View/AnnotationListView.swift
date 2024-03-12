//
//  AnnotationListView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 05/03/24.
//

import SwiftUI

struct AnnotationListView: View {
    @StateObject private var viewModel: AnnotationListViewModel
    var body: some View {
        List(viewModel.annotations) { annotation in
            VStack(alignment: .leading) {
                Text(annotation.wrappedTitle)
                    .font(.title3)
                    .bold()
                Text(annotation.wrappedCommentDescription)
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
            .onTapGesture {
                viewModel.showingFormView(annotation)
            }
            .contextMenu {
                Button("Delete Annotation", systemImage: Icons.trash.rawValue, role: .destructive) {
                    viewModel.deleteAnnotation(annotation)
                }
            }
        }
        .navigationTitle("Annotations")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchAnnotations()
        }
        .onChange(of: viewModel.annotations) { oldValue, newValue in
            if viewModel.annotations != oldValue {
                viewModel.annotations = newValue
            }
        }
        .toolbar {
            Button {
                viewModel.showingFormView()
            } label: {
                Icons.plus.systemImage
            }
        }
        .sheet(isPresented: $viewModel.showingAddAnotationView) {
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
        AnnotationListView(storage: .preview, book: dummyBook)
    }
}
