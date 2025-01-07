//
//  NewGenreView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/5/25.
//

import ErrorWrapper
import SwiftUI

struct NewGenreView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            SingleFormEdit(name: $viewModel.title)
                .navigationTitle("New Genre")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        SaveButton {
                            viewModel.createNewGenre()
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
    NewGenreView()
}
