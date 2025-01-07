//
//  EditAnnotationView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/4/25.
//

import ErrorWrapper
import SwiftUI

struct EditAnnotationView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            AnnotationEdit(
                title: $viewModel.title,
                commentDescription: $viewModel.commentDescription,
                lastUpdate: viewModel.annotation.wrappedLastModification
            )
            .navigationTitle("Edit Annotation")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButton {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    SaveButton {
                        viewModel.saveChanges {
                            dismiss()
                        }
                    }
                }
            }
        }
    }
    
    init(annotation: Annotation) {
        self._viewModel = State(
            initialValue: .init(
                annotation: annotation
            )
        )
    }
}

#Preview {
    let preview = PreviewBook()
    EditAnnotationView(annotation: preview.books[0].wrappedAnnotations[0])
}
