//
//  AnnotationPopulaedView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 30/03/24.
//

import SwiftUI

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
    let book = Book(context: Storage.preview.context)
    
    return AnnotationListView(storage: .preview, book: book)
}
