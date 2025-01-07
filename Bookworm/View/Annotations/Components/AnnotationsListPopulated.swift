//
//  AnnotationsListPopulated.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/4/25.
//

import SwiftUI

extension AnnotationsView {
    struct AnnotationsListPopulated: View {
        @Binding var annotation: Annotation?
        
        @Environment(ViewModel.self) private var viewModel
        
        var body: some View {
            List(viewModel.annotations) { annotation in
                VStack(alignment: .leading) {
                    Text(annotation.wrappedTitle)
                        .font(.title3)
                        .bold()
                    Text(annotation.wrappedCommentDescription)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
                .onTapGesture {
                    self.annotation = annotation
                }
                .contextMenu {
                    DeleteButton(target: "Annotation") {
                        viewModel.deleteAnnotation(annotation)
                    }
                }
            }
        }
    }
}

#if DEBUG
#Preview {
    let preview = PreviewBook()
    
    AnnotationsView.AnnotationsListPopulated(
        annotation: .constant(
            preview.books[0].wrappedAnnotations[0]
        )
    )
    .environment(
        AnnotationsView.ViewModel(
            storage: .preview,
            bookTitle: preview.books[0].wrappedTitle,
            annotations: preview.books[0].wrappedAnnotations
        )
    )
}
#endif
