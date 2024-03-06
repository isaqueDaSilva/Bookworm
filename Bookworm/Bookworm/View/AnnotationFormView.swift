//
//  AnnotationFormView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 05/03/24.
//

import SwiftUI

struct AnnotationFormView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var viewModel: AnnotationFormViewModel
    
    var action: () -> Void
    
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
                            viewModel.deleteAnnotation {
                                action()
                                dismiss()
                            }
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
                        viewModel.saveChanges {
                            action()
                            dismiss()
                        }
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
        book: Book,
        action: @escaping () -> Void
    ) {
        _viewModel = StateObject(wrappedValue: AnnotationFormViewModel(storage: storage, annotation: annotation, book: book))
        self.action = action
    }
}

#Preview {
    AnnotationFormView(storage: .preview, book: dummyBook) { }
}
