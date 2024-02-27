//
//  CreateAccountView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 26/02/24.
//

import SwiftUI

struct CreateAccountView: View {
    @Environment(\.dismiss) var dismiss
    @FocusState var focusedField: Field?
    @StateObject private var viewModel = CreateAccountViewModel()
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                VStack(alignment: .center, spacing: 4) {
                    Text("Let's Get Started!")
                        .font(.title)
                        .foregroundStyle(Color(uiColor: .systemBlue))
                        .fontWeight(.heavy)
                    
                    Text("Create an account to Bookworm to get all features")
                        .font(.subheadline)
                        .bold()
                        .foregroundStyle(.secondary)
                }
                .multilineTextAlignment(.center)
                .frame(width: geo.size.width)
                
                VStack(spacing: 20) {
                    EntryField(
                        label: Text("Name"),
                        content: TextField("Insert your name here...", text: $viewModel.name),
                        leadingAccessoryView: Icons.person.systemImage
                    )
                    .focused($focusedField, equals: .name)
                    
                    EntryField(
                        label: Text("Usename"),
                        content: TextField("Insert your username here...", text: $viewModel.username),
                        leadingAccessoryView: Icons.person.systemImage
                    )
                    .focused($focusedField, equals: .username)
                    
                    EntryField(
                        label: Text("Email"),
                        content: TextField("Insert your email here...", text: $viewModel.email),
                        leadingAccessoryView: Icons.envelope.systemImage
                    )
                    .focused($focusedField, equals: .email)
                    
                    EntryField(
                        label: Text("Password"),
                        content: SecureFieldWithToggle(title: "Insert your email here...", text: $viewModel.password),
                        leadingAccessoryView: Icons.key.systemImage
                    )
                    .focused($focusedField, equals: .password)
                    
                    EntryField(
                        label: Text("Confirm Password"),
                        content: SecureFieldWithToggle(title: "Insert your email here...", text: $viewModel.confirmPassword),
                        leadingAccessoryView: Icons.key.systemImage
                    )
                    .focused($focusedField, equals: .confirmPassword)
                    .padding(.bottom)
                    
                    ActionButton(title: "Create", isLoadingState: viewModel.isLoadingState) {
                        if viewModel.isValid() {
                            viewModel.craeteAccount()
                            dismiss()
                        } else {
                            focusedField = viewModel.backToFocusField()
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Create account")
            .navigationBarTitleDisplayMode(.inline)
            .alert(
                viewModel.errorTitle,
                isPresented: $viewModel.showingError
            ) { } message: {
                Text(viewModel.errorMessage)
            }
        }
    }
}

extension CreateAccountView {
    enum Field: Hashable {
        case name, username, email, password, confirmPassword
    }
}

#Preview {
    NavigationStack {
        CreateAccountView()
    }
}
