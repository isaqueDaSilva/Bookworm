//
//  AnnotationFormView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 05/03/24.
//

import SwiftUI

struct AnnotationFormView: View {
    // MARK: - View Properties
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: AnnotationFormViewModel
    
    // MARK: - View
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Insert the title here...", text: $viewModel.title)
                    TextField("Insrt the comment here...", text: $viewModel.commentDescription, axis: .vertical)
                        .lineLimit(10, reservesSpace: true)
                } footer: {
                    Text("Last Modification: \(viewModel.lastUpdate)")
                }
                
                if viewModel.isEditMode {
                    Section {
                        Button(role: .destructive) {
                            viewModel.deleteAnnotation()
                            dismiss()
                        } label: {
                            Label("Delete Annotation", systemImage: Icons.trash.rawValue)
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Icons.chevronLeft.systemImage
                            Text("Back")
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.saveChanges()
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
    }
    
    init(
        storage: Storage,
        annotation: Annotation? = nil,
        book: Book
    ) {
        _viewModel = StateObject(wrappedValue: AnnotationFormViewModel(storage: storage, annotation: annotation, book: book))
    }
}

#Preview {
    AnnotationFormView(storage: .preview, book: Storage.dummyBook)
}
