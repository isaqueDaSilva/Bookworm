//
//  ProfileLoad.swift
//  Bookworm
//
//  Created by Isaque da Silva on 08/02/24.
//

import SwiftUI

extension ProfileView {
    @ViewBuilder
    func ProfileLoad() -> some View {
        List {
            Section {
                HStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        Description(
                            title: viewModel.username,
                            description: viewModel.email,
                            primaryFont: .title3,
                            secondaryFont: .subheadline
                        )
                    }
                    Spacer()
                    Menu("Edit") {
                        Button {
                            viewModel.displayEditNameAlert()
                        } label: {
                            Label("Edit Username", systemImage: "pencil")
                        }
                    }
                }
            }
            
            Section {
                DestructiveButton(mode: $viewModel.signOutButtonMode, label: "Sign Out") {
                    viewModel.signOut()
                }
            }
            
            Section {
                DestructiveButton(mode: $viewModel.deleteButtonMode, label: "Delete this account") {
                    viewModel.deleteUser()
                }
            }
        }
        .navigationTitle(viewModel.name)
        .alertWithTextField(
            text: $viewModel.editUsername,
            isActive: $viewModel.isEditNameActive,
            title: "Edit Username",
            primaryButtonTitle: "OK",
            secondaryButtonTitle: "Cancel",
            message: "Insert your new username in the session below.",
            placeholder: "Username",
            isDisabled: viewModel.isDisabled,
            secondaryRole: .cancel,
            primaryAction: viewModel.updateUsername
        )
        .alert(viewModel.errorTitle, isPresented: $viewModel.showingError) {
        } message: {
            Text(viewModel.errorMessage)
        }
    }
}
