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
        // START: NAV
        NavigationStack {
            // START: FORM
            Form {
                // START: SECTION 1
                Section {
                    TextField("Insert the title here...", text: $viewModel.title)
                    TextField("Insrt the comment here...", text: $viewModel.commentDescription, axis: .vertical)
                        .lineLimit(10, reservesSpace: true)
                } footer: {
                    Text("Last Modification: \(viewModel.lastUpdate)")
                }
                // END: SECTION 1
                
                if viewModel.isEditMode {
                    // START: SECTION 2
                    Section {
                        Button(role: .destructive) {
                            viewModel.deleteAnnotation()
                            dismiss()
                        } label: {
                            Label("Delete Annotation", systemImage: Icons.trash.rawValue)
                                .foregroundStyle(.red)
                        }
                    }
                    // END: SECTION 2
                }
            }
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        // Dismiss the view.
                        
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
                        // save the changes that occurred
                        // and dismiss the view
                        // when the action is finished
                        
                        viewModel.saveChanges()
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
    }
    
    /// The view shows the form for user will be create or update some annotation of the some book.
    /// 
    /// - Parameters:
    ///   - storage: An association with an Author value that determines whether there are any authors selected or not.
    ///   - annotation: A saved note, which will be used to perform some updates.
    ///   - book: The representation of the book in which the annotation will be inserted, removed or edited
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
