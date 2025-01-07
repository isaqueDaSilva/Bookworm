//
//  NewAnnotationView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/4/25.
//

import SwiftUI

struct NewAnnotationView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = ViewModel()
    
    private let book: Book
    
    var body: some View {
        NavigationStack {
            AnnotationEdit(
                title: $viewModel.title,
                commentDescription: $viewModel.commentDescription
            )
            .navigationTitle("New annottaion")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButton {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    SaveButton {
                        viewModel.createAnnotation(withBook: book)
                        dismiss()
                    }
                }
            }
        }
    }
    
    init(book: Book) {
        self.book = book
    }
}

#Preview {
    let preview = PreviewBook()
    
    NewAnnotationView(book: preview.books[0])
}
