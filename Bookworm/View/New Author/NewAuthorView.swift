//
//  NewAuthorView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/4/25.
//

import ErrorWrapper
import SwiftUI

struct NewAuthorView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            SingleFormEdit(name: $viewModel.authorName)
                .navigationTitle("New Author")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        SaveButton {
                            viewModel.createNewAuthor()
                            dismiss()
                        }
                        .disabled(!viewModel.isValidCreationValid)
                    }
                    
                    ToolbarItem(placement: .cancellationAction) {
                        BackButton {
                            dismiss()
                        }
                    }
                }
                .errorAlert(error: $viewModel.error) { }
        }
    }
}

#Preview {
    NewAuthorView()
}
